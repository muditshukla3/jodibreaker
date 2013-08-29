from django.conf import settings
from django.contrib.sites.models import Site
from django.core.urlresolvers import reverse
from django.db.models.aggregates import Count
from django.http import HttpResponse
from django.shortcuts import render_to_response, render
from django.template import RequestContext
from django_facebook.decorators import facebook_required
from forms import UserJodiForm
from httplib import HTTPResponse
from models import FacebookUserProfile, Jodi, UserJodi, Vote
import json

@facebook_required()
def home(request, graph):
    firstName = '';
    print 'in home view'
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
        
        form = UserJodiForm()
        
        return render_to_response('from.html', {'facebookName':me['first_name'], 'form':form, 'facebookid':me['id']}, context_instance=RequestContext(request))
    else:
        return HTTPResponse('Bad Request')

def index(request):
    message = 'Hello';
    return render(request, 'index.html', {'message':message})

@facebook_required
def trendingjodi(request, graph):
    print 'in trending jodi'

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
        message = 'I have selected ' + selected_jodi + ' from JodiApp'
        picture_path = 'http://timesofindia.indiatimes.com/photo/16627860.cms'
        linkUrl = Site.objects.get(id=settings.SITE_ID).domain
        linkUrl = linkUrl + reverse('vote', kwargs={'jodiid':created_jodi.id})
#         linkUrl='www.google.com'
        graph.set('me/feed', message=message, picture=picture_path, link=linkUrl)
        return render_to_response('treading_jodi.html', {'selected_jodi':selected_jodi, 'name':fb_profile.facebook_firstname, 'trending_jodi':trending_list}, context_instance=RequestContext(request))
    
def vote(request, jodiid):
    print 'in vote'
    print jodiid
   
    message = ''
    if request.method == 'POST':
        jodi = UserJodi.objects.get(id=jodiid)
        profile = FacebookUserProfile.objects.get(facebook_id=request.POST.get('fb_id'))
        vote = Vote.objects.filter(jodi=jodi, profile=profile)
        if vote:
            message = 0
        else:
            kwargs = {'profile':profile, 'jodi_id':jodi}
            Vote.objects.create(**kwargs)
            jodi.counter =jodi.counter+1
            jodi.save()
            message = 1
            
    return HttpResponse(json.dumps({'status':message}), mimetype="application/json")                
        
        
        
        
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
