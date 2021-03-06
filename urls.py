from django.conf.urls.defaults import patterns, include, url
from django.conf import settings
from django.views.generic.simple import direct_to_template
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
                        url(r'^$', 'jodibreakerapp.views.index', name='index'),
                        url(r'^home/', 'jodibreakerapp.views.home', name='home'),
                        url(r'^video/$', direct_to_template,{'template':'video.html'},name='video'),
                        url(r'^trendingjodis/','jodibreakerapp.views.trendingjodi',name='trendingjodi'),
                        url(r'^vote/(?P<jodiid>\d+)/$','jodibreakerapp.views.voteView',name='voteView'),
                        url(r'^castvote/$','jodibreakerapp.views.castVote',name='castVote'),
                        url(r'^wallpost/$','jodibreakerapp.views.view_wallpost',name='post_on_wall'),
                        url(r'^leader-board/$','jodibreakerapp.views.leader_board',name='leader_board'),
                        url(r'^facebook/', include('django_facebook.urls')),
                        url(r'^accounts/', include('django_facebook.auth_urls')),
                        url(r'^terms/', direct_to_template,{'template':'term_and_condition.html'},name='terms'),
                        url(r'^aboutus/', direct_to_template,{'template':'about.html'},name='about'),
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
