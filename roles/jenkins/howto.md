# Jenkins Mater 部署

# Jenkins Node IaC Runner 设置
1. 安装git terraform

## GitLab to trigger Jenkins

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

## 要将GitHub代码仓库与Jenkins关联起来，您需要完成以下步骤：

1 要在 GitHub 中启用 webhook 功能以触发 Jenkins 构建，请按照以下步骤操作：
2 进入 GitHub 仓库设置：在要设置 webhook 的 GitHub 仓库页面上，点击右上角的“Settings”。
3 选择 Webhooks 选项：在仓库设置页面的左侧菜单中，选择“Webhooks”。
4 添加 Webhook：在 Webhooks 页面的右上角，点击“Add webhook”。

配置 Webhook：

1. Payload URL：输入 Jenkins 服务器的 webhook URL。格式应为 http://your-jenkins-server/github-webhook/。确保替换 your-jenkins-server 为您 Jenkins 服务器的实际地址。
2. Content type：选择 application/json。
3. Secret（可选）：如果需要额外的安全性，可以输入一个秘密令牌。
4. SSL verification：选择是否验证 SSL 证书。
5. Which events would you like to trigger this webhook?：选择触发 webhook 的事件。通常选择 Just the push event（只有推送事件）或 Let me select individual events（让我选择单独的事件）并选择适当的事件（例如，push、pull request 等）。
添加 Webhook：点击页面底部的“Add webhook”按钮以保存配置。

完成以上步骤后，您的 GitHub 仓库就配置好了一个 webhook，可以触发 Jenkins 构建。记得在 Jenkins 中设置相应的任务来响应这些 webhook。


安装Jenkins插件：

确保您的Jenkins实例已经安装了“GitHub”和“GitHub Integration”插件。您可以在Jenkins管理界面的“插件管理”部分进行安装。
配置GitHub Webhook：

在GitHub仓库的设置中，找到“Webhooks”部分并添加一个新的Webhook。
将“Payload URL”设置为您的Jenkins服务器的URL，通常是这样的格式：http://<JENKINS_URL>/github-webhook/。
选择触发Webhook的事件，通常是“Just the push event”或者“Send me everything”。
确保“Content type”设置为“application/json”。
点击“Add webhook”保存设置。
配置Jenkins Job：

在Jenkins中创建一个新的构建任务或者配置现有的任务。
在“源码管理”部分，选择“Git”并填写您的GitHub仓库的URL。
在“构建触发器”部分，选择“GitHub hook trigger for GITScm polling”选项。这样，每当GitHub仓库有新的推送事件时，Jenkins就会自动触发构建。
测试配置：

推送一些改动到您的GitHub仓库，检查是否触发了Jenkins构建。
在Jenkins的构建历史中查看构建是否成功执行。
通过完成以上步骤，您的GitHub代码仓库就与Jenkins关联起来了，可以实现自动触发构建的功能。
