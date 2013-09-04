from views import view_trending

def trending_jodi(request):
    trending_jodi_list =view_trending()
    print 'in context processor ',trending_jodi_list
    return {'trending_jodi':trending_jodi_list}
