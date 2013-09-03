from django.conf.urls.defaults import patterns, include, url
from django.conf import settings
from django.views.generic.simple import direct_to_template
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
                       url(r'^$', 'jodibreaker.jodibreakerapp.views.index', name='index'),
                       url(r'^home/', 'jodibreaker.jodibreakerapp.views.home', name='home'),
						url(r'^video/$', direct_to_template,{'template':'video.html'},name='video'),
                       url(r'^trendingjodis/','jodibreaker.jodibreakerapp.views.trendingjodi',name='trendingjodi'),
                       url(r'^vote/(?P<jodiid>\d+)$','jodibreaker.jodibreakerapp.views.voteView',name='voteView'),
                       url(r'^facebook/', include('django_facebook.urls')),
                       url(r'^accounts/', include('django_facebook.auth_urls')),
                       url(r'^admin/', include(admin.site.urls)),
    # Examples:
    # url(r'^$', 'jodibreaker.views.home', name='home'),
    # url(r'^jodibreaker/', include('jodibreaker.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
)
urlpatterns += patterns("django.views",
        url(r'^media(?P<path>.*)/$',
            "static.serve", {
            "document_root": settings.MEDIA_ROOT,
        })
    )
