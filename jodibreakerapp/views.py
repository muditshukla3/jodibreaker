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
import logging
import json
import urllib2


logger = logging.getLogger('view')
@facebook_required()
def home(request, graph):
    
    firstName = ''
    templateName = ''
    
    
    print 'in home view'
   
    
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
            jodi=UserJodi.objects.get(profile=fbProfile)
            if jodi:
                request.session['fb_id']=fbprofile.facebook_id
                trendingjodi(request, graph)
        form = UserJodiForm()

        return render_to_response(templateName, {'facebookName':me['first_name'], 'form':form, 'facebookid':me['id']}, context_instance=RequestContext(request))
    else:
        return HTTPResponse('Bad Request')

def index(request):
    if request.session.get("voteid") and request.method == 'GET':
        url = request.session.get("voteid")[2:]
        url = urllib2.unquote(url)
        url_lst = url.split("&")
        if len(url_lst) >1:
            url = url_lst[0]

        del request.session["voteid"]
        return redirect(url)
    message = 'Hello';
    if '/fb/' in request.get_full_path():
        templateName = '/fb/index.html'
    else:
        templateName = 'index.html'
    return render(request, templateName, {'message':message})

@facebook_required
def trendingjodi(request, graph):

    
    if '/fb/' in request.get_full_path():
        templateName = '/fb/treading_jodi.html'
    else:
        templateName = 'treading_jodi.html'
        
    if request.method == 'GET':
       fb_id=request.session['fb_id']
       fbProfile=FacebookUserProfile.objects.get(facebook_id=fb_id)
       jodi=UserJodi.objects.get(profile=fbProfile)
       jodiRank=getJodiRank(jodi.id)
       return render_to_response(templateName, {'selected_jodi':jodi.jodi_custom, 'jodiRank':jodiRank, 'name':fbProfile.facebook_firstname}, context_instance=RequestContext(request)) 
            
    if request.method == 'POST':
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
            selected_jodi = jodi_custom
        else:
            jodi = Jodi.objects.get(id=int(jodi))
            kwargs['jodi_custom'] = jodi
            selected_jodi = jodi.jodi
        created_jodi = UserJodi.objects.create(**kwargs)
        trending_list = view_trending()
        print created_jodi.id
        print created_jodi.jodi_custom
        # Call to post on wall

        #message = 'I have selected ' + selected_jodi + ' from JodiApp'
        message = 'I have chosen' + selected_jodi + 'as my favorite \'Jodi\' in the Rewading Jodi Batao contest.'
        picture_path = 'http://www.pointeeworld.com/media/images/goa_jao.png/'
        #linkUrl = Site.objects.get(id=settings.SITE_ID).domain
        #linkUrl = linkUrl + reverse('voteView', kwargs={'jodiid':created_jodi.id})+'/'
        linkUrl = 'http://www.pointeeworld.com/' + reverse('voteView', kwargs={'jodiid':created_jodi.id})+'/'
        description = 'Please vote for my \'Jodi\' and make me win a free trip to Goa!'
#         linkUrl='www.google.com'
        graph.set('me/feed', message=message, picture=picture_path, link=linkUrl, description=description)

        # finding rank of jodi
        jodiRank = getJodiRank(created_jodi.id)
        return render_to_response(templateName, {'selected_jodi':selected_jodi, 'jodiRank':jodiRank, 'name':fb_profile.facebook_firstname, 'trending_jodi':trending_list}, context_instance=RequestContext(request))



def voteView(request, jodiid):


    if '/fb/' in request.get_full_path():
        templateName = '/fb/vote.html'
    else:
        templateName = 'vote.html'
        
    userJodi = UserJodi.objects.get(id=int(jodiid))
    
    return render_to_response(templateName, {'jodi_creator':userJodi.profile.facebook_firstname , 'jodi':userJodi.jodi_custom,'jodiid':userJodi.id}, context_instance=RequestContext(request))
    
@facebook_required        
def castVote(request, graph):
    message = ''
    if request.method == 'POST':
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
        jodi= UserJodi.objects.get(id=int(request.POST.get('jodiid')))

        vote = Vote.objects.filter(jodi=jodi, profile=profile)
        if vote:  # if already voted
            message = 'You have already voted for this jodi'
        else:  # if not voted
            kwargs = {'profile':profile, 'jodi':jodi}
            Vote.objects.create(**kwargs)
            jodi.counter = jodi.counter + 1
            jodi.save()
            message = 'Thanks for Voting'
      
    return render_to_response('vote.html', {'message':message,'name':profile.facebook_firstname}, context_instance=RequestContext(request))      
#     return HttpResponse(json.dumps({'status':message}), mimetype="application/json")                
                
def getJodiRank(jodi_id):
    print 'in jodi rank'
    jodi_id_list = ''
    if jodi_id:
        jodi_id_list = list(UserJodi.objects.all().order_by('-counter').values_list('id', flat=True))
        rank = jodi_id_list.index(jodi_id)
        return rank
                
def view_trending():
#     jodi_id_list = UserJodi.objects.values_list('jodi').annotate(dcount=Count('jodi'))
    jodi_custom_list = UserJodi.objects.values_list('jodi_custom').annotate(dcount=Count('jodi_custom'))
    jodi_dict = {}
#     for jodi in jodi_id_list:
#         if jodi[0]:
#             key = Jodi.objects.get(id=jodi[0]).jodi
#             jodi_dict[key] = jodi[1]
    for jodi in jodi_custom_list:
        if jodi[0]:
            jodi_dict[jodi[0]] = jodi[1]
    trending_jodi_list = sorted(jodi_dict, key=jodi_dict.get, reverse=True)        
    return trending_jodi_list
