VERSION = 1.1.0
APP_NAME = model-hub
# 容器名称
CONTAINER_NAME = model-hub
# 配置文件路径
CONFIG_PATH = $(PWD)/config.json
# 镜像名称
IMAGE_NAME = $(APP_NAME):$(VERSION)

# 构建镜像
build:
	@echo "正在构建镜像，标签为 $(IMAGE_NAME)..."
	@docker build -t $(IMAGE_NAME) .

# 运行容器
run:
	@echo "正在运行容器，名称为 $(CONTAINER_NAME)..."
	@docker run -d -p 7096:3000 --name $(CONTAINER_NAME) -v $(CONFIG_PATH):/model-hub/public/config.json $(IMAGE_NAME)

# 停止容器
stop:
	@echo "正在停止容器 $(CONTAINER_NAME)..."
	@docker stop $(CONTAINER_NAME)

# 删除容器和镜像
clean:
	@echo "正在检查并删除容器 $(CONTAINER_NAME)..."
	@docker ps -a | grep -q $(CONTAINER_NAME) && docker rm $(CONTAINER_NAME) || echo "容器 $(CONTAINER_NAME) 不存在"
	@echo "正在检查并删除镜像 $(IMAGE_NAME)..."
	@docker images | grep -q $(APP_NAME) && docker rmi $(IMAGE_NAME) || echo "镜像 $(IMAGE_NAME) 不存在"

rm:
	@$(MAKE) stop && $(MAKE) clean

# 打包+运行
run-quick:
	@$(MAKE) build && $(MAKE) run

.PHONY: build run stop clean run-quick
