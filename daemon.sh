create()
{
	oci network public-ip create --compartment-id ocid1.tenancy.oc1..aaaaaaaatabcjvdherv4wxpc26obfv733wvr24eylrg7otxl4zw5pl5qimda --lifetime EPHEMERAL --private-ip-id=ocid1.privateip.oc1.uk-london-1.abwgiljs22bv473dgoh3b35aespxtmdhqrzqzmyk2jhmsz7cfr5qw2rgi6yq
}

list()
{
	JSON=$(oci network public-ip list --compartment-id ocid1.tenancy.oc1..aaaaaaaatabcjvdherv4wxpc26obfv733wvr24eylrg7otxl4zw5pl5qimda --scope AVAILABILITY_DOMAIN --availability-domain="XECv:UK-LONDON-1-AD-2" --all | jq)

	jq -r '.data[] | .id' <<< "$JSON"
}

delete()
{
	ID=$(bash listIp.sh)
	yes|oci network public-ip delete --public-ip-id="$ID"
	echo Deleted'!'
}

delay=1400
while true;do
	date
	echo Switchings IPS...

	delete

	create

	sleep "$delay"
done