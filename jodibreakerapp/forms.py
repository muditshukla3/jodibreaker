from django import forms
from models import Jodi,UserJodi

JODI_CHOICE=list(Jodi.objects.values_list('id','jodi'))
JODI_CHOICE.insert(0,(0,'-Choose Jodi-'))
 
class UserJodiForm(forms.Form):
    jodi=forms.ChoiceField(choices=JODI_CHOICE,widget=forms.Select(attrs={'class' : 'styled'}))
    jodi_custom=forms.CharField(max_length=50)