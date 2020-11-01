FROM python:3.6.1-alpine
WORKDIR /project
EXPOSE 5000
ADD . /project
RUN pip install -r requirements.txt
CMD ["python","app.py"]