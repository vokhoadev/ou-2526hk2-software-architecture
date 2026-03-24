# Đăng ký Tài khoản Cloud

## Thời lượng: 1 giờ

## Tổng quan

Các labs Cloud Native (Level 6) yêu cầu tài khoản cloud. Tất cả các nhà cung cấp đều có **Free Tier** cho phép thực hành mà không tốn phí.

---

## 1. AWS Free Tier (Bắt buộc)

### Tại sao cần?
- Labs 5.1, 5.2: AWS Fundamentals, Serverless
- Labs 5.5, 5.6: Terraform, EKS
- Capstone Projects

### Đăng ký

1. Truy cập: https://aws.amazon.com/free/
2. Click "Create a Free Account"
3. Điền thông tin:
 - Email address
 - Password
 - AWS account name
4. Xác minh danh tính:
 - Số điện thoại
 - Credit/Debit card (không bị charge nếu trong Free Tier)
5. Chọn Support Plan: **Basic Support - Free**

### Free Tier bao gồm (12 tháng)
- **EC2**: 750 giờ/tháng t2.micro
- **S3**: 5GB storage
- **RDS**: 750 giờ/tháng db.t2.micro
- **Lambda**: 1 triệu requests/tháng
- **DynamoDB**: 25GB storage
- **CloudWatch**: 10 custom metrics

### Cấu hình AWS CLI

```bash
# Cài đặt (nếu chưa)
# Windows: choco install awscli
# macOS: brew install awscli

# Cấu hình
aws configure

# Nhập:
# AWS Access Key ID: [từ IAM Console]
# AWS Secret Access Key: [từ IAM Console]
# Default region name: ap-southeast-1
# Default output format: json
```

### Tạo IAM User (Recommended)

1. AWS Console > IAM > Users > Create user
2. User name: `lab-user`
3. Permissions: Attach policies directly
 - AdministratorAccess (cho học tập)
4. Create user
5. Security credentials > Create access key
6. Lưu Access Key ID và Secret Access Key

### Budget Alert (Quan trọng!)

1. AWS Console > Billing > Budgets
2. Create budget
3. Cost budget
4. Monthly budget amount: $5
5. Alert threshold: 80%
6. Email notification

---

## 2. Azure Free Account (Khuyến khích)

### Tại sao cần?
- Lab 6.3: Azure Basics
- Lab 6.6: AKS

### Đăng ký

1. Truy cập: https://azure.microsoft.com/free/
2. Click "Start free"
3. Đăng nhập với Microsoft account
4. Điền thông tin và xác minh card

### Free Tier bao gồm
- **$200 credit** trong 30 ngày đầu
- **12 tháng free services**:
 - 750 giờ B1s VM
 - 5GB Blob Storage
 - 250GB SQL Database
- **Always free**:
 - 1 triệu Azure Functions requests/tháng
 - 5GB Cosmos DB

### Cấu hình Azure CLI

```bash
# Cài đặt
# Windows: winget install Microsoft.AzureCLI
# macOS: brew install azure-cli

# Login
az login

# Kiểm tra subscription
az account show
```

---

## 3. Google Cloud Platform (Optional)

### Tại sao cần?
- Lab 6.4: GCP Overview
- Lab 6.6: GKE

### Đăng ký

1. Truy cập: https://cloud.google.com/free
2. Click "Get started for free"
3. Đăng nhập với Google account
4. Điền thông tin và xác minh card

### Free Tier bao gồm
- **$300 credit** trong 90 ngày đầu
- **Always free**:
 - 1 f1-micro VM/tháng
 - 5GB Cloud Storage
 - 2 triệu Cloud Functions invocations/tháng
 - 30GB Cloud Shell storage

### Cấu hình gcloud CLI

```bash
# Cài đặt
# Download từ: https://cloud.google.com/sdk/docs/install

# Init
gcloud init

# Login
gcloud auth login

# Set project
gcloud config set project YOUR_PROJECT_ID
```

---

## 4. GitHub Account (Bắt buộc)

### Tại sao cần?
- Lab 7.2: GitHub Actions
- Version control cho tất cả labs

### Đăng ký

1. Truy cập: https://github.com/
2. Sign up
3. Verify email

### Cấu hình

```bash
# SSH Key
ssh-keygen -t ed25519 -C "your_email@example.com"
cat ~/.ssh/id_ed25519.pub

# Copy và thêm vào GitHub > Settings > SSH and GPG keys
```

### GitHub Student Developer Pack (Optional)

Nếu bạn là sinh viên:
1. https://education.github.com/pack
2. Verify student status
3. Nhận nhiều free tools và credits

---

## 5. Docker Hub Account (Bắt buộc)

### Tại sao cần?
- Push/pull Docker images
- Lab 5.1, 5.2: Docker

### Đăng ký

1. Truy cập: https://hub.docker.com/
2. Sign up
3. Verify email

### Login từ CLI

```bash
docker login
# Nhập username và password
```

---

## 6. Terraform Cloud (Optional)

### Tại sao cần?
- Lab 6.5: Terraform remote state

### Đăng ký

1. Truy cập: https://app.terraform.io/
2. Create account
3. Create organization

### Free Tier
- 500 managed resources
- Remote state storage
- VCS integration

---

## Checklist Hoàn thành

- [ ] AWS account đã tạo và verified
- [ ] AWS CLI đã cấu hình (`aws sts get-caller-identity` works)
- [ ] AWS Budget alert đã set up
- [ ] Azure account đã tạo (optional)
- [ ] GCP account đã tạo (optional)
- [ ] GitHub account đã tạo
- [ ] SSH key đã add vào GitHub
- [ ] Docker Hub account đã tạo
- [ ] Docker login thành công

---

## Lưu ý Quan trọng

### Tránh tốn phí không mong muốn

1. **Luôn stop/terminate resources** sau khi thực hành
2. **Set billing alerts** ở mức thấp ($5-10)
3. **Dùng Free Tier eligible** resources
4. **Không chạy resources 24/7** trừ khi cần thiết
5. **Check billing dashboard** hàng tuần

### Cleanup Commands

```bash
# AWS - List running EC2
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name]'

# AWS - Terminate EC2
aws ec2 terminate-instances --instance-ids i-xxxxx

# Terraform - Destroy
terraform destroy

# Kubernetes - Delete cluster
minikube delete
# hoặc
eksctl delete cluster --name my-cluster

# Docker - Cleanup
docker system prune -a
```

---

## Tiếp theo

Sau khi hoàn thành:
- `tools-setup.md` - Cài đặt công cụ bổ sung
- Bắt đầu `01-foundations/` labs
