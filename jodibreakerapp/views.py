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
        form = UserJodiForm()

        return render_to_response(templateName, {'facebookName':me['first_name'], 'form':form, 'facebookid':me['id']}, context_instance=RequestContext(request))
    else:
        return HTTPResponse('Bad Request')

def index(request):
    if request.session.get("voteid") and request.method == 'GET':
        url = request.session.get("voteid")
#         url = 'www.pointeeworld.com' + url
#         url = request.session.get("voteid")[2:]
#         url = urllib2.unquote(url)
#         url_lst = url.split("&")
#         if len(url_lst) >1:
#             url = url_lst[0]

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
    picture_path = 'http://www.pointeeworld.com/media/images/goa_jao.png/'
    linkUrl = 'http://www.pointeeworld.com/' + reverse('voteView', kwargs={'jodiid':args[2]})+'/'
    description = get_random_desc()
    graph.set('me/feed', message=message, picture=picture_path, link=linkUrl, description=description)

@facebook_required
def view_wallpost(request, graph):

    msg = '0'
    if request.method == 'POST':
        jodi_id = request.POST.get('sharenow')
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
       fb_id=request.session['fb_id']
       fb_profile=FacebookUserProfile.objects.get(facebook_id=fb_id)
       jodi=UserJodi.objects.get(profile=fb_profile)
    else:
        jodi = request.POST.get('jodi')
        jodi_custom = request.POST.get('jodi_custom')
        fb_profile = FacebookUserProfile.objects.get(facebook_id=request.POST.get('fb_id'))
        mobile = request.POST.get('mobile_no')
        if mobile:
            fb_profile.mobile_no = mobile
            fb_profile.save()
        kwargs = {'profile':fb_profile}
        if jodi_custom:
            kwargs['jodi_custom'] = jodi_custom
        else:
            jodi = Jodi.objects.get(id=int(jodi))
            kwargs['jodi_custom'] = jodi.jodi
        jodi = UserJodi.objects.create(**kwargs)
        # Call to post on wall
        post_on_wall(graph,jodi.jodi_custom, jodi.id)
        # finding rank of jodi
    jodiRank = getJodiRank(jodi.id)
    data = {'selected_jodi':jodi, 'jodiRank':jodiRank, 
            'name':fb_profile.facebook_firstname, 'redirect':redirect}
    return render_to_response(templateName, data, context_instance=RequestContext(request))



def voteView(request, jodiid):

    if '/fb/' in request.get_full_path():
        templateName = '/fb/vote.html'
    else:
        templateName = 'vote.html'
    userJodi = UserJodi.objects.get(id=int(jodiid))
    data = {'jodi_creator':userJodi.profile.facebook_firstname , 
            'jodi':userJodi.jodi_custom,
            'jodiid':userJodi.id}
    return render_to_response(templateName, data, context_instance=RequestContext(request))
    
@facebook_required
def castVote(request, graph):

        message = ''

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
            profile=profile[0]    
        jodi= UserJodi.objects.get(id=int(request.GET.get('jodiid')))

        vote = Vote.objects.filter(jodi=jodi, profile=profile)
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
