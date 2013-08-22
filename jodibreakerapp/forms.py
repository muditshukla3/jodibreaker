from django import forms
from models import Jodi,UserJodi

JODI_CHOICE=list(Jodi.objects.values_list('id','jodi'))
JODI_CHOICE.insert(0,(0,'-Choose Jodi-'))
 
class UserJodiForm(forms.Form):
    jodi=forms.ChoiceField(choices=JODI_CHOICE,widget=forms.Select(attrs={'class' : 'styled sel_jodi'}))
    jodi_custom=forms.CharField(widget=forms.TextInput(attrs={'class':'cus_jodi','maxlength':'50'}))