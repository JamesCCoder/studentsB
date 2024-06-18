# 使用官方的 Python 镜像作为基础镜像
FROM python:3.10-slim

# 设置工作目录
WORKDIR /app

# 将当前目录的内容复制到工作目录
COPY . /app

# 安装依赖项
RUN pip install --no-cache-dir -r requirements.txt

# 确认文件结构
RUN ls /app
RUN ls /app/student_management_backend

# 设置环境变量
ENV DJANGO_SETTINGS_MODULE=student_management_backend.settings
ENV PYTHONPATH=/app

# 确认环境变量
RUN echo $DJANGO_SETTINGS_MODULE
RUN echo $PYTHONPATH

# 运行数据库迁移
RUN python3 manage.py migrate

# 运行 Django 应用程序
CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:8000", "student_management_backend.wsgi:application"]
