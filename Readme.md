gcloud config set project test-teraform

gcloud services enable container.googleapis.com

terraform init

terraform plan

terraform apply


gcloud container clusters get-credentials my-gke-cluster --region asia-northeast1-a

gcloud docker -- push gcr.io/test-teraform/citest:b

