from rest_framework import serializers

from django.contrib.sites.models import Site
from django.utils.translation import ugettext_lazy as _

from apps.users.serializers import CreateUserSerializer

from .models import Tenant


def unique_site_domain(value):

    domain = "{}.{}".format(value, Tenant.objects.get_tenant_root_domain())

    try:
        Site.objects.get(domain=domain)
        raise serializers.ValidationError(_('There is already an domain with that name.'))
    except Site.DoesNotExist:
        pass


class TenantSignUpSerializer(serializers.ModelSerializer):
    """
        Serialize data from the tenant (the administration user, who registers for the SaaS.
        A name and domain is used to start an tenant environment. The given user will be the first admin.
    """

    subdomain = serializers.CharField(
        label=_("subdomain"),
        help_text="The subdomain will be created for the tenant",
        write_only=True,
        validators=[unique_site_domain])

    user = CreateUserSerializer(write_only=True)

    class Meta:
        """ """
        model = Tenant
        fields = ('id', 'name', 'subdomain', 'user')
        extra_kwargs = {'name': {'write_only': True}}

    def get_cleaned_data(self):
        return {
            'name': self.validated_data.get('name', ''),
            'subdomain': self.validated_data.get('subdomain', ''),
            'user': self.validated_data.get('user', '')
        }

    def save(self, request):

        self.cleaned_data = self.get_cleaned_data()
        user_serializer = CreateUserSerializer(data=self.cleaned_data["user"])

        user_serializer.is_valid(raise_exception=True)
        user = user_serializer.save(request)

        Tenant.objects.create_tenant(user=user, name=self.cleaned_data["name"], subdomain=self.cleaned_data["subdomain"])

        return user
