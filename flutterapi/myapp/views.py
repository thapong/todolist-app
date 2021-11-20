from django.shortcuts import render
from django.http import JsonResponse

from rest_framework.response  import  Response
from rest_framework.decorators import api_view
from rest_framework import status
from rest_framework.serializers import Serializer 
from .serializers import TodolistSerializer
from .models import Todolist 

#Get data 


@api_view(['GET'])

def all_todolist(request):
    alltodolist = Todolist.objects.all()
    serializer = TodolistSerializer(alltodolist,many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['POST'])
def post_todolist(request):
    if  request.method == 'POST' : 
         serializer =  TodolistSerializer(data=request.data)
         if serializer.is_valid():
            serializer.save()
            return Response(serializer.data,status=status.HTTP_201_CREATED)
         return Response(serializer.errors,status=status.HTTP_404_NOT_FOUND)    
     
@api_view(['PUT'])
def update_todolist(request,TID):
    todo = Todolist.objects.get(id=TID)
       
    if  request.method == 'PUT' : 
          data= {}
          serializer =  TodolistSerializer(todo,data=request.data)
          if serializer.is_valid():
                serializer.save()
                data['status'] = 'updated'
                return Response(data=data,status=status.HTTP_201_CREATED)
          return Response(serializer.errors,status=status.HTTP_404_NOT_FOUND)    
      
      
@api_view(['DELETE'])
def delete_todolist(request,TID):
    todo =Todolist.objects.get(id=TID)
    
    if request.method == 'DELETE' :
        delete = todo.delete()
        data ={}
        if delete :
            data['status'] ='deleted'
            statuscode=status.HTTP_201_CREATED
        else :
            data['status'] ='failed'
            statuscode=status.HTTP_404_NOT_FOUND       
        return Response(data=data,status=statuscode)  
    

data  = [ 
    {  "title" : "Central-Thailand",
       "detail": "Central Thailand is mainly plains and is a huge area of rice farming and agriculture.",
       "imageUrl" : "https://raw.githubusercontent.com/thapong/flutterlab/17ca403bf9ec069aed00e3b2b7cb99c767060b39/center.jpg",
       "story" :"An increasing of tourists visiting Bangkok each year has proven that Bangkok is always a popular city for tourists.\nFor major tourist attractions in Bangkok, most of them are Historical sites or religious sites such as temples in Bangkok. There is beautiful architecture, wall painting and also important in History, such as Wat Phra Sri Rattanasamaram (Phra Kaew), Wat Phra Chetuphon Wimon Mangalaram (wat pho), wat arun Ratchawararam, Wat Sra Ket, and Phra Bor Banphot (Golden mountain), Wat Ratchanadda, Wat Traimit, Wat Benchamabophit, Wat Bowonniwet Vihara Suthasan, Wat Thep Wararam etc.There are also other interesting places such as palaces, museums, parks, as well as various Shopping centres in Bangkok. There are both chilling places like Chatuchak Weekend Market, Sampeng Market, Yaowarat and Phahurat night market or luxury level such as many leading department stores in all areas of Bangkok as well."
    },
    {
        "title" : "North-Thailand",
        "detail": "The northernmost point is Amphoe Mae Sai, Chiang Rai Province, with tourist attractions like Mae Sai Market, Golden Triangle.",
        "imageUrl" : "https://raw.githubusercontent.com/thapong/flutterlab/17ca403bf9ec069aed00e3b2b7cb99c767060b39/north.jpg",
        "story" :"Wat Phra That Doi Wao\nWith beautiful nature blended with Lanna Culture and colours of contemporary perfectly Chiang Mai is, therefore, a province that has many tourists, both Thai and foreigners, come in many millions each year.\n Popular tourist activities in Chiang Mai include worshipping the Phra That doi suthep, which is an important Landmark of Chiang Mai people. Experience the local way of life and shop for stylish handmade products at Thapae Walking Street. Visit various species of plants at the Queen Sirikit botanical Garden and Rajapruek Royal Park. Do not miss to shop art products, taste local CUISINE and see cultures on Nimmanhaemin Road. In addition, nature and mountain tours are another activity that should not be missed when visiting Chiang Mai, whether stepping on the highest point of Thailand at the top of doi inthanon. Absorb the beauty of the rice fields, feel the Cool breeze while watching the giant tiger flower at Doi Ang Khang. Experience Ecotourism HomeStay in Mae Kampong and visit Hmong villages in Doi Pui and many more."

    },
    {
        "title" : "East-Thailand",
        "detail": "Eastern Thailand is half mountain, half ocean.Thailand such as Koh Samed, Koh Chang, Koh Mak, Koh Lan, Koh Si Chang.",
        "imageUrl" : "https://raw.githubusercontent.com/thapong/flutterlab/17ca403bf9ec069aed00e3b2b7cb99c767060b39/east.jpg",
        "story" :"Chachoengsao is an old town by the Bang Pakong River popularly known as \"Pad Riew\", bordering Bangkok. Travelling to Chachoengsao province does not take long.\nWhen talking about Chachoengsao province people tend to think of the province's priceless monk, \"Luang Phor Sothon\", an important Buddha statue of Thailand. In addition, Chachoengsao province is famous for its mangoes. During the mango season, Fruits Festivals are held every year. "

    },

    {
        "title" : "South-Thailand",
        "detail": "The South contains many beautiful beaches and islands in the Gulf of Thailand and the Andaman Sea.",
        "imageUrl" : "https://raw.githubusercontent.com/thapong/flutterlab/17ca403bf9ec069aed00e3b2b7cb99c767060b39/south.jpg",
        "story" :"chumphon city, the capital of Chumphon province, is the gateway to Thailand’s southern provinces as well as the Islands in the Gulf of Thailand.\n Particularly Koh Tao. With more than 200 kilometres of coastline featuring numerous unspoiled beaches, Chumphon is an ideal Destination for those who are seeking relaxation in a natural and quiet atmosphere and wish to enjoy such activities as sunbathing, swimming, yachting, paragliding, diving, and Snorkelling."

    }
    ]
def Home(request):
    return JsonResponse(data=data,safe=False,json_dumps_params={'ensure_ascii':False})
