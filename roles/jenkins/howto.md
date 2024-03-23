# Jenkins Mater 部署

# Jenkins Node IaC Runner 设置
1. 安装git terraform

# GitLab to trigger Jenkins

1. Gitlab https://gitlab.xxx.com/-/profile/personal_access_tokens 

2. GitLab和Jenkins的集成可以让你在GitLab中的代码更新后自动触发Jenkins的构建任务。以下是配置GitLab插件和Jenkins以实现GitLab触发Jenkins的步骤：
3. 在Jenkins中安装GitLab插件
首先，你需要在Jenkins中安装GitLab插件。登录到Jenkins的管理界面，然后转到“Manage Jenkins” > “Manage Plugins” > “Available”，在搜索框中输入“GitLab”，找到并安装“GitLab Plugin”。
4. 在Jenkins中配置GitLab连接
安装完插件后，你需要配置GitLab的连接。转到“Manage Jenkins” > “Configure System”，滚动到“GitLab”部分，点击“Add GitLab Server” > “Server”，输入你的GitLab服务器URL，并生成并输入一个与你的GitLab账户相关联的API Token。
5. 在Jenkins中创建一个新的任务
创建一个新的任务，并在源代码管理部分选择“Git”，输入你的GitLab项目的URL。在构建触发器部分，选择“Build when a change is pushed to GitLab”。
记录:GitLab webhook URL: https://jenkins.xxx.xxx/project/alicloud-oss-pipeline
6. 在GitLab中配置Webhook
在你的GitLab项目中，转到“Settings” > “Integrations” -> 启用"Jenkins"
- 在URL中输入步骤5记录的 Webhook URL https://jenkins.xxx.xxx/project/alicloud-oss-pipeline
- 选择你想要触发Jenkins任务的事件（例如，当代码被推送时）
- Project name: 输入项目名称
- Username: Jenkins 用户名
- Password: Jenkins 认证密码
- 保存更改, 测试设置，返回状态200为配置正确

以上就是配置GitLab插件和Jenkins以实现GitLab触发Jenkins的步骤。在完成这些步骤后，每当你的GitLab项目有更新时，都会自动触发对应的Jenkins构建任务。
