from views import view_trending

def trending_jodi(request):
    trending_jodi_list =view_trending()
    return {'trending_jodi':trending_jodi_list}