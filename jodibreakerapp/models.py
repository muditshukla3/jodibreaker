from django.db import models

 
class FacebookUserProfile(models.Model):
    facebook_id = models.BigIntegerField(blank=True, unique=True, null=True)
    facebook_username= models.CharField(max_length=255, blank=True, null=True)
    facebook_firstname = models.CharField(max_length=255, blank=True, null=True)
    email=models.EmailField()
    city=models.CharField(max_length=100,null=True,blank=True)
    mobile_no=models.BigIntegerField(blank=True, unique=True, null=True)
    
    def __unicode__(self):
        return self.facebook_name
    
class Jodi(models.Model):
    jodi=models.CharField(max_length=50,unique=True)
    
    def __unicode__(self):
        return self.jodi
    
class UserJodi(models.Model):
    jodi=models.ForeignKey(Jodi,null=True)
    jodi_custom=models.CharField(max_length=50,null=True)
    profile=models.ForeignKey(FacebookUserProfile)
    
    def __unicode__(self):
        return self.jodi_custom    
