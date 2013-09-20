from django.db import models
from django_facebook.models import FacebookProfileModel
from django.contrib.auth.models import User
from django.db.models.signals import post_save
 
class FacebookUserProfile(FacebookProfileModel):
    user = models.OneToOneField('auth.User', null=True)
#     facebook_id = models.BigIntegerField(blank=True, unique=True, null=True)
    facebook_username= models.CharField(max_length=255, blank=True, null=True)
    facebook_firstname = models.CharField(max_length=255, blank=True, null=True)
    email=models.EmailField()
    city=models.CharField(max_length=100,null=True,blank=True)
    mobile_no=models.CharField(max_length=255, blank=True, null=True)
    
    def __unicode__(self):
        return self.facebook_firstname
    
#Make sure we create a MyCustomProfile when creating a User
def create_facebook_profile(sender, instance, created, **kwargs):
    if created:
        FacebookUserProfile.objects.create(user=instance)

post_save.connect(create_facebook_profile, sender=User)
    
class Jodi(models.Model):
    jodi=models.CharField(max_length=50,unique=True)
    
    def __unicode__(self):
        return self.jodi
    
class UserJodi(models.Model):
#     jodi=models.ForeignKey(Jodi,null=True)
    jodi_custom=models.CharField(max_length=50,null=True)
    profile=models.ForeignKey(FacebookUserProfile)
    counter=models.IntegerField(default=0)
    
    def __unicode__(self):
        return self.profile.facebook_firstname
    
class Vote(models.Model):
    jodi=models.ForeignKey(UserJodi)
    profile=models.ForeignKey(FacebookUserProfile)        
