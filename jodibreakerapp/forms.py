from django import forms
from models import Jodi

JODI_CHOICE=list(Jodi.objects.values_list('id','jodi'))
JODI_CHOICE.insert(0,(0,'-Choose Jodi-'))
 
class UserJodiForm(forms.Form):
    jodi=forms.ChoiceField(choices=[],widget=forms.Select(attrs={'class' : 'styled sel_jodi'}))
    jodi_custom=forms.CharField(widget=forms.TextInput(attrs={'class':'cus_jodi','maxlength':'50'}))
    
    def __init__(self):
        super(UserJodiForm,self).__init__()
        self.fields['jodi'].choices=JODI_CHOICE
        