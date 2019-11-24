gcloud config set project test-teraform

gcloud services enable container.googleapis.com

terraform init

terraform plan

terraform apply


gcloud container clusters get-credentials my-gke-cluster --region asia-northeast1-a

gcloud docker -- push gcr.io/test-teraform/citest:b

helm install concourse -f myvalues.yaml stable/concourse -n concourse

./fly -t citest sp -p citest-deploy -c pipline/citest-deploy.yaml -l pipline/credentials/credentials.yml

export project_id=$(gcloud config get-value project)
export account=gcr-user
export service_account_email=${account}@${project_id}.iam.gserviceaccount.com
gcloud iam service-accounts create gcr-user
gcloud iam service-accounts keys create ~/gcr.key.json --iam-account ${service_account_email}
gcloud projects add-iam-policy-binding ${project_id} --member serviceAccount:${service_account_email} --role roles/storage.admin

