from django import forms
from models import Jodi


class UserJodiForm(forms.Form):
    jodi=forms.ChoiceField(choices=[],widget=forms.Select(attrs={'class' : 'styled sel_jodi'}))
    jodi_custom=forms.CharField(widget=forms.TextInput(attrs={'class':'cus_jodi','maxlength':'50','placeholder':'Enter your Jodi','holder':'Enter your Jodi'}))
    
    def __init__(self):
        super(UserJodiForm,self).__init__()
        JODI_CHOICE=list(Jodi.objects.values_list('id','jodi'))
        JODI_CHOICE.insert(0,(0,'-Choose Jodi-'))
        self.fields['jodi'].choices=JODI_CHOICE
        
