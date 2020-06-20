
from django.shortcuts import render
import pymysql as ms
import datetime


def Show_Index(request):
    database=ms.connect("localhost","root","root","mail",port=3306,cursorclass=ms.cursors.DictCursor)
    cursor=database.cursor()
    ctx = {}
    mention=""
    login=""
    if request.POST:
        try:
            login=request.POST['login']
        except:
            pass
        name=request.POST['name']
        sql="select * from goods where Goods_Name like %s"
        cursor.execute(sql,['%'+name+'%'])
        if name!="":
            mention="Result of "+name
        pass
    else:
        sql="select * from goods;"
        cursor.execute(sql)
    data=cursor.fetchall()
    content={}
    if login!="":
        content['login']=login;
    content['Result']=mention
    content['Goods']=data
    return render(request,'index.html',content)

# def Register(request):
#     return render(request,'register.html')
#
# def Finish_Register(request):
#     database = ms.connect("localhost", "root", "root", "mail", port=3306, cursorclass=ms.cursors.DictCursor)
#     cursor = database.cursor()
#     ctx = {}
#     status=False
#     result="False: "
#     if request.POST:
#         telephone=request.POST['Tel']
#         name=request.POST['name']
#         nick=request.POST['Nickname']
#         email=request.POST['email']
#         gender=request.POST['gender']
#         password=request.POST['Password']
#         pwd=request.POST['Pwd']
#         date=str(datetime.datetime.now())[0:19]
#         if pwd==password:
#             sql="insert into customer values('0',%s,%s,%s,%s,md5(%s),'0',%s);"
#             cursor.execute(sql,[name,nick,email,gender,password,date])
#             cache=cursor.fetchall()
#             id=""
#             sql="select from customer where customer_name like %s and customer_register_time like %s"
#             cursor.execute(sql,[name,date])
#             temp=cursor.fetchall()
#             sql="insert into customer_telephone values(%s,);"
#             status=True
#         else:
#             result+="Two password are not the same. Try again please."
#     if status:
#         content={}
#         content['register']="You have registered successfully. Please login."
#         return render(request,'login.html',content)
#     else:
#         content={}
#         content['Result']=result
#         return render(request,'register.html',content)


def Login(request):
    return render(request,'login.html')

def Finish_Login(request):
    status=False
    account=request.POST['Account']
    password=request.POST['Password']
    database = ms.connect("localhost", "root", "root", "mail", port=3306, cursorclass=ms.cursors.DictCursor)
    cursor = database.cursor()
    ctx = {}
    sql="select * from customer where customer_id like %s and customer_password like md5(%s);"
    result=cursor.execute(sql,[account,password])
    status=cursor.fetchall()
    if status:
        sql="select * from goods;"
        cursor.execute(sql)
        info=cursor.fetchall()
        # return render(request,'index.html',{'login':account})
        return render(request,'index.html',{'login':account,'Goods':info})
    else:
        return render(request,'login.html',{'wrong':"Login false."})

def User(request):
    database = ms.connect("localhost", "root", "root", "mail", port=3306, cursorclass=ms.cursors.DictCursor)
    cursor = database.cursor()
    ctx = {}
    if str(request.POST['button'])=="Logout":
        sql="select * from goods;"
        cursor.execute(sql)
        info=cursor.fetchall()
        return render(request,"index.html",{'Goods':info})
    if str(request.POST['button'])=="My Order":
        login=request.POST['login']
        content={}
        content['login']=login
        sql="select * from customer_order where customer_order_id like %s;"
        cursor.execute(sql,[login])
        order=cursor.fetchall()
        if order:
            content['order']=order
        else:
            content['empty']="Your do not have any order before."
        return render(request,'order.html',content)
    if str(request.POST['button'])=="Shopping Cart":
        login=request.POST['login']
        content={}
        content['login']=login
        sql="select * from shopping_cart where shopping_cart_customer_id like %s order by shopping_cart_time desc;"
        lines=cursor.execute(sql,[login])
        data=cursor.fetchall()
        if data:
            for i in range(len(data)):
                sql="select * from goods where Goods_ID like %s;"
                cursor.execute(sql, [data[i]['Shopping_Cart_Goods_ID']])
                good_info=cursor.fetchall()
                print(good_info[0])
                data[i].update(good_info[0])
            # item=[]
            # for i in data:
            #     print(i)
            #     sql="select * from goods where Goods_ID like %s;"
            #     cursor.execute(sql,[i['Shopping_Cart_Goods_ID']])
            #     item+=cursor.fetchall()
            # content['goods']=item
            content['shopping_cart']=data
            # content['shopping_cart']+=item
        else:
            content['empty']="Your Shopping Cart is Empty."
        return render(request,'shopping_cart.html',content)

def Add(request):
    login=request.POST['login']
    pass

def Buy(request):
    pass

def Order_Manage(request):
    pass

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