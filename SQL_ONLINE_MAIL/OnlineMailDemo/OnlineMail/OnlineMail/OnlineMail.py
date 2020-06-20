
from django.shortcuts import render
import pymysql as ms
import datetime


def Show_Index(request):
    database=ms.connect("localhost","root","root","mail",port=3306,cursorclass=ms.cursors.DictCursor)
    cursor=database.cursor()
    ctx = {}
    mention=""
    if request.POST:
        name=request.POST['name']
        sql="select * from goods where Goods_Type like %s"
        cursor.execute(sql,['%'+name+'%'])
        if name!="":
            mention="Result of "+name
        pass
    else:
        sql="select * from goods;"
        cursor.execute(sql)
    data=cursor.fetchall()
    content={}
    content['Result']=mention
    content['Goods']=data
    return render(request,'index.html',content)

def Register(request):
    return render(request,'register.html')

def Finish_Register(request):
    database = ms.connect("localhost", "root", "root", "mail", port=3306, cursorclass=ms.cursors.DictCursor)
    cursor = database.cursor()
    ctx = {}
    status=False
    result="False: "
    if request.POST:
        telephone=request.POST['Tel']
        name=request.POST['name']
        nick=request.POST['Nickname']
        email=request.POST['email']
        gender=request.POST['gender']
        password=request.POST['Password']
        pwd=request.POST['Pwd']
        date=str(datetime.datetime.now())[0:19]
        if pwd==password:
            sql="insert into customer values('0',%s,%s,%s,%s,md5(%s),'0',%s);"
            cursor.execute(sql,[name,nick,email,gender,password,date])
            cache=cursor.fetchall()
            id=""
            sql="select from customer where customer_name like %s and customer_register_time like %s"
            cursor.execute(sql,[name,date])
            temp=cursor.fetchall()
            sql="insert into customer_telephone values(%s,);"
            status=True
        else:
            result+="Two password are not the same. Try again please."
    if status:
        content={}
        content['register']="You have registered successfully. Please login."
        return render(request,'login.html',content)
    else:
        content={}
        content['Result']=result
        return render(request,'register.html',content)


def Login(request):
    return render(request,'login.html')

def Finish_Login(request):
    status=False
    if status:
        return render(request,'index.html')
    else:
        return render(request,'login.html')

#  db = pymysql.connect("localhost", "root", “password", "test", port=3306, cursorclass = pymysql.cursors.DictCursor)
#  cursor = db.cursor()
#  ctx = {}
#  if request.POST:
#  name = request.POST['name']
#  sql = "select * from student where name like %s"
#  cursor.execute(sql, ['%'+name+'%'])
#  else:
#  sql = "select * from student"
#  cursor.execute(sql)
#  data = cursor.fetchall()
#  context = {}
#  context['students'] = data
#  return render(request, 'student.html', context)