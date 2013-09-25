from django.conf import settings
from django.contrib.sites.models import Site
from django.core.urlresolvers import reverse
from django.db.models.aggregates import Count
from django.http import HttpResponse
from django.shortcuts import render_to_response, render, redirect
from django.template import RequestContext
from django_facebook.decorators import facebook_required
from forms import UserJodiForm
from httplib import HTTPResponse
from models import FacebookUserProfile, Jodi, UserJodi, Vote
from random import randint
from django.core.exceptions import MultipleObjectsReturned

import logging
import json
import urllib2


logger = logging.getLogger('view')
@facebook_required()
def home(request, graph):

    firstName = ''
    templateName = ''
    if '/fb/' in request.get_full_path():
        templateName = '/fb/from.html'
    else:
        templateName = 'from.html'
    if request.method == 'GET':
        me = graph.get('me')
        fbprofile = FacebookUserProfile.objects.filter(facebook_id=me['id'])
        kwargs = {'facebook_id':me['id']}
        if me.get('username'):
            kwargs['facebook_username'] = me['username']
        if me.get('first_name'):
            kwargs['facebook_firstname'] = me['first_name']
        if me.get('email'):
            kwargs['email'] = me['email']
        if me.get('location'):
            loc = me.get('location')
            if loc.get('name'):
                kwargs['city'] = me['location']['name']
        kwargs['mobile_no'] = ''
        if not fbprofile:
            FacebookUserProfile.objects.create(**kwargs)
        else:
            jodi=UserJodi.objects.filter(profile=fbprofile[0])
            if jodi:
                request.session['fb_id']=fbprofile[0].facebook_id
                return trendingjodi(request, graph, redirect=1)
            else:
                if me.get('username'):
                    fbprofile[0].facebook_username = me['username']
                if me.get('first_name'):
                    fbprofile[0].facebook_firstname = me['first_name']
                if me.get('email'):
                    fbprofile[0].email = me['email']
                if me.get('location'):
                    loc = me.get('location')
                    if loc.get('name'):
                        fbprofile[0].city = me['location']['name']
                fbprofile[0].save()
        form = UserJodiForm()
        return render_to_response(templateName, {'facebookName':me['first_name'], 'form':form, 'facebookid':me['id']}, context_instance=RequestContext(request))
    else:
        return HTTPResponse('Bad Request')

def index(request):

    if request.session.get("voteid") :
        url = "http://www.pointeeworld.com" + request.session.get("voteid")
        del request.session["voteid"]
        return redirect(url)
    message = 'Hello';
    if '/fb/' in request.get_full_path():
        templateName = '/fb/index.html'
    else:
        templateName = 'index.html'
    return render(request, templateName, {'message':message})

def get_random_desc():
    desc_dict = {1:"Please vote for my 'Jodi' and make me win a free trip to Goa!",
                 2:"Vote for my favorite 'Jodi' to help me win a free trip to Goa.",
                 3:"Help me win this contest by voting for my favorite 'Jodi'. Winners get a free trip to Goa."}
    return desc_dict[randint(1,3)]
    

def post_on_wall(*args):
    graph = args[0]
    message = 'I have chosen ' + args[1] + ' as my favorite \'Jodi\' in the Rewading Jodi Batao contest.'
    picture_path = 'https://www.pointeeworld.com/media/images/goa_jao.png/'
    domain = Site.objects.get_current()
    linkUrl = domain.name + reverse('voteView', kwargs={'jodiid':args[2]})+'/'
    description = get_random_desc()
    graph.set('me/feed', message=message, picture=picture_path, link=linkUrl, description=description)

@facebook_required
def view_wallpost(request, graph):
    msg = '0'
    #if request.method == 'POST':
    jodi_id = request.REQUEST.get('sharenow')
    jodi = UserJodi.objects.filter(id=int(jodi_id))
    if jodi:
        me = graph.get('me')
        fbprofile = FacebookUserProfile.objects.filter(facebook_id=me['id'])
        if fbprofile[0] and jodi[0].profile.id == fbprofile[0].id:
            post_on_wall(graph, jodi[0].jodi_custom, jodi[0].id)
            msg = '1'
    return HttpResponse(json.dumps({'message':msg}),mimetype="application/json")

@facebook_required
def trendingjodi(request, graph, redirect=None):

    if '/fb/' in request.get_full_path():
        templateName = '/fb/treading_jodi.html'
    else:
        templateName = 'treading_jodi.html'
        
    if request.method == 'GET':
        fb_id=request.session.get('fb_id',None)
        fb_profile=FacebookUserProfile.objects.filter(facebook_id=fb_id)
        if fb_profile:
            try:
                jodi=UserJodi.objects.get(profile=fb_profile[0])
            except MultipleObjectsReturned:
               return HttpResponse('You have already created jodi') 
        else:
            return HttpResponse('Wrong data')
    else:

        createflag = 1
        jodi = request.POST.get('jodi')
        jodi_custom = request.POST.get('jodi_custom')
        fb_profile = FacebookUserProfile.objects.filter(facebook_id=int(request.POST.get('fb_id')))
        mobile = request.POST.get('mobile_no')
        if fb_profile:
            if mobile:
                fb_profile[0].mobile_no = mobile
                fb_profile[0].save()
            kwargs = {'profile':fb_profile[0]}
            jodi=UserJodi.objects.filter(profile=fb_profile[0])
            if jodi:
                createflag = 0
        else:
            return HttpResponse('Wrong data')
        if jodi_custom:
            kwargs['jodi_custom'] = jodi_custom
        else:
            jodi = Jodi.objects.get(id=int(jodi))
            kwargs['jodi_custom'] = jodi.jodi
        if createflag == 0:
            return HttpResponse('You have already created jodi')
        jodi = UserJodi.objects.create(**kwargs)
        # Call to post on wall
        post_on_wall(graph,jodi.jodi_custom, jodi.id)
            # finding rank of jodi
            
    jodiRank = getJodiRank(jodi.id)
    data = {'selected_jodi':jodi, 'jodiRank':jodiRank, 
            'name':fb_profile[0].facebook_firstname, 'redirect':redirect}
    return render_to_response(templateName, data, context_instance=RequestContext(request))

def voteView(request, jodiid):

    if '/fb/' in request.get_full_path():
        templateName = '/fb/vote.html'
    else:
        templateName = 'vote.html'
    userJodi = UserJodi.objects.filter(id=int(jodiid))
    if not userJodi:
        return HttpResponse('Wrong data')
    data = {'jodi_creator':userJodi[0].profile.facebook_firstname , 
            'jodi':userJodi[0].jodi_custom,
            'jodiid':userJodi[0].id}
    return render_to_response(templateName, data, context_instance=RequestContext(request))
    
@facebook_required
def castVote(request, graph):
        message = ''
        flag = 0
    #if request.method == 'POST':
        me = graph.get('me')
        profile = FacebookUserProfile.objects.filter(facebook_id=me['id'])
        kwargs = {'facebook_id':me['id']}
        if me.get('username'):
            kwargs['facebook_username'] = me['username']
        if me.get('first_name'):
            kwargs['facebook_firstname'] = me['first_name']
        if me.get('email'):
            kwargs['email'] = me['email']
        if me.get('location'):
            loc = me.get('location')
            if loc.get('name'):
                kwargs['city'] = me['location']['name']
        kwargs['mobile_no'] = ''
        
        if not profile:
            profile=FacebookUserProfile.objects.create(**kwargs)
        else:
            flag = 1
            profile=profile[0]    
        jodi= UserJodi.objects.get(id=int(request.GET.get('jodiid')))
        vote = Vote.objects.filter(jodi=jodi, profile=profile)
        if flag == 1 and not vote:
            if me.get('username'):
                profile.facebook_username = me['username']
            if me.get('first_name'):
                profile.facebook_firstname = me['first_name']
            if me.get('email'):
                profile.email = me['email']
            if me.get('location'):
                loc = me.get('location')
                if loc.get('name'):
                    profile.city = me['location']['name']
            profile.save()
        if profile == jodi.profile:
            message = 'You can not voted on your jodi'
        elif vote:  # if already voted
            message = 'You have already voted for this jodi'
        else:  # if not voted
            kwargs = {'profile':profile, 'jodi':jodi}
            Vote.objects.create(**kwargs)
            jodi.counter = jodi.counter + 1
            jodi.save()
            message = 'Thanks for Voting'
      
        return render_to_response('vote.html', {'message':message,'jodi':jodi.jodi_custom,'name':profile.facebook_firstname}, context_instance=RequestContext(request))
#     return HttpResponse(json.dumps({'status':message}), mimetype="application/json")                
                
def getJodiRank(jodi_id):
    rank = 0
    jodi_id_list = ''
    if jodi_id:
        jodi_id_list = list(UserJodi.objects.all().order_by('-counter').values_list('id', flat=True))
        rank = jodi_id_list.index(jodi_id)
        return rank
                
def view_trending():
    jodi_custom_list = UserJodi.objects.values_list('jodi_custom').annotate(dcount=Count('jodi_custom'))
    jodi_dict = {}
    for jodi in jodi_custom_list:
        if jodi[0]:
            jodi_dict[jodi[0]] = jodi[1]
    trending_jodi_list = sorted(jodi_dict, key=jodi_dict.get, reverse=True)        
    return trending_jodi_list

def leader_board(request):
    jodis = UserJodi.objects.all().order_by('-counter')
#     users = FacebookUserProfile.objects.all()
    return render_to_response('leaderboard.html', {'jodis':jodis}, context_instance=RequestContext(request))
