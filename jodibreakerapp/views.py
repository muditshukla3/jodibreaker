from django.shortcuts import render_to_response, render
from django.template import RequestContext
from django_facebook.decorators import facebook_required
from forms import UserJodiForm
from httplib import HTTPResponse
from models import FacebookUserProfile, Jodi, UserJodi

@facebook_required()
def home(request, graph):
    firstName = '';
    print 'in home view'
    if request.method == 'GET':
        me = graph.get('me')
        fbprofile = FacebookUserProfile.objects.filter(facebook_id=me['id'])
        if not fbprofile:
            FacebookUserProfile.objects.create(facebook_id=me['id'],
                                           facebook_username=me['username'],
                                           facebook_firstname=me['first_name'],
                                           email=me['email'],
                                           city=me['location']['name'],
                                           mobile_no=None)
        
        form = UserJodiForm()
        
        return render_to_response('from.html', {'facebookName':me['first_name'], 'form':form,'facebookid':me['id']},context_instance=RequestContext(request))
    else:
        return HTTPResponse('Bad Request')

def index(request):
    message = 'Hello';
    return render(request, 'index.html', {'message':message})

@facebook_required
def trendingjodi(request):
    if request.method == 'POST':
        jodi = request.POST.get('jodi')
        jodi_custom=request.POST.get('jodi_custom')
        fb_profile = FacebookUserProfile.objects.get(facebook_id=request.POST.get('fb_id'))
        mobile=request.POST.get('mobile_no')
        if mobile:
            fb_profile.mobile_no=mobile
            fb_profile.save()
            
        kwargs={'profile':fb_profile}
        if jodi_custom:
            kwargs['jodi_custom'] = jodi_custom
            selected_jodi=jodi_custom
        else:
            jodi = Jodi.objects.get(id=int(jodi))
            kwargs['jodi'] = jodi
            selected_jodi=jodi.jodi
        UserJodi.objects.create(**kwargs)
        return render_to_response('treading_jodi.html',{'selected_jodi':selected_jodi,'name':fb_profile.facebook_firstname},context_instance=RequestContext(request))