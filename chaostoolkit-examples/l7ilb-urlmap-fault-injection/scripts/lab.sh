jq 'del(.rollbacks) | .method[0].pauses.after = 135' ../chaos-experiment/config/experiment.json >../chaos-experiment/config/o_experiment.json
mv ../chaos-experiment/config/o_experiment.json ../chaos-experiment/config/experiment.json

sudo chmod -R 777 ~/chaos-engineering
sleep 60
echo "Starting up...."
student_user=$(gcloud config get-value account)

gcloud projects add-iam-policy-binding ${GOOGLE_CLOUD_PROJECT} \
--member="user:${student_user}" \
--role='roles/iam.serviceAccountTokenCreator'

gcloud projects add-iam-policy-binding ${GOOGLE_CLOUD_PROJECT} \
--member="user:${student_user}" \
--role='roles/iam.serviceAccountUser'

gcloud projects add-iam-policy-binding ${GOOGLE_CLOUD_PROJECT} \
--member="user:${student_user}" \
--role='roles/serviceusage.serviceUsageAdmin'

gcloud projects add-iam-policy-binding ${GOOGLE_CLOUD_PROJECT} \
--member="user:${student_user}" \
--role='roles/iap.tunnelResourceAccessor'

gsutil mb gs://${GOOGLE_CLOUD_PROJECT}-terraform-backend
sudo mkdir -p /opt/chaostoolkit-examples/
sudo chmod -R 777 /opt/chaostoolkit-examples

./1-init.sh
echo "provisioning .."
sleep 60
./2-provision.sh

