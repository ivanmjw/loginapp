from django.db import models
from django.contrib.auth.models import User

class LoginLog(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    login_time = models.DateTimeField(auto_now_add=True)
    ip_address = models.GenericIPAddressField(null=True, blank=True)
    
    class Meta:
        ordering = ['-login_time']

    def __str__(self):
        return f"{self.user.username} - {self.login_time}"
