echo "building image"
docker compose build

echo "Login to OpenShift"
echo "openshift username:"
read username
oc login -u $username api.ul-pca-pr-ul01.ulaval.ca:6443

oc project ul-val-genovalia-pr

echo "Login to Registry"
docker login -u `oc whoami` -p `oc whoami --show-token` registre.apps.ul-pca-pr-ul01.ulaval.ca

echo "Push image"
docker push registre.apps.ul-pca-pr-ul01.ulaval.ca/ul-val-genovalia-pr/semantic-engine:latest

#echo "Deploying image"
#oc rollout latest dc/site-web-genovalia
