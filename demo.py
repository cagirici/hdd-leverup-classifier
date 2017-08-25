import cv2
import numpy as np
import json
import time
drawing = False # true if mouse is pressed
mode = True # if True, draw rectangle. Press 'm' to toggle to curve
ix,iy,ix2,iy2 = -1,-1,-1,-1
lines=dict()
lines['lever_up_able']=list()
lines['nonlever_up_able']=list()
counter=0
crop_count=0
img = cv2.imread('IMG_5978.JPG')
img2 = cv2.imread('IMG_5978.JPG')
last = cv2.imread('IMG_5978.JPG')
cv2.namedWindow('image',cv2.WINDOW_NORMAL)
cv2.resizeWindow('image',1008,756)
# mouse callback function
def draw_line(event,x,y,flags,param):
	global ix,iy,ix2,iy2,drawing,mode,counter,lever_up_able,lines,crop_count,last,img
	

	if event == cv2.EVENT_LBUTTONDOWN:
		print x
		print y
		if counter == 0:
			ix,iy = x,y
			counter=1
		elif counter == 1 :
			ix2,iy2 = x,y		
			if mode:
				counter= 2	
				cv2.line(img,(ix,iy),(x,y),(0,0,255),20)

				lines['lever_up_able'].append( (ix,iy,x,y) )
				max_num_of_images=max(abs((x-ix)/100),abs((y-iy)/100))
				x_range=(x-ix)/max_num_of_images
				y_range=(y-iy)/max_num_of_images
				for i in range(1,max_num_of_images):
					crop_count=crop_count+1
					cv2.circle(img,(x-i*x_range,y-i*y_range), 15, (255,0,0), 10)
					crop_img = img2[y-i*y_range-100:y-i*y_range+100, x-i*x_range-100:x-i*x_range+100]
					cv2.imwrite('5978\pos\cropped_'+str(crop_count)+'.jpg',crop_img)
				last=img.copy()			
			else:
				counter= 0
				cv2.line(img,(ix,iy),(x,y),(255,0,0),20)
				lines['nonlever_up_able'].append( (ix,iy,x,y) )
				max_num_of_images=max(abs((x-ix)/100),abs((y-iy)/100))
				x_range=(x-ix)/max_num_of_images
				y_range=(y-iy)/max_num_of_images
				for i in range(1,max_num_of_images):
					crop_count=crop_count+1
					cv2.circle(img,(x-i*x_range,y-i*y_range), 15, (0,0,255), 10)
					crop_img = img2[y-i*y_range-100:y-i*y_range+100, x-i*x_range-100:x-i*x_range+100]
					cv2.imwrite('5978\\neg\cropped_'+str(crop_count)+'.jpg',crop_img)
				last=img.copy()
		else :
			ix3=(ix+ix2)/2
			iy3=(iy+iy2)/2
			cv2.arrowedLine(img,(ix3,iy3),(x,y), (0,0,255),20)
			last=img.copy()
			counter = 0

	elif event == cv2.EVENT_MOUSEMOVE:
		if counter == 1 :
			img=last.copy()
			if mode == True:
				cv2.line(img,(ix,iy),(x,y),(0,0,255), 20)
			else:
				cv2.line(img,(ix,iy),(x,y),(255,0,0),20)
			time.sleep(0.025)
		elif counter == 2 :
			img=last.copy()
			if mode == True:
				ix3=(ix+ix2)/2
				iy3=(iy+iy2)/2
				cv2.arrowedLine(img,(ix3,iy3),(x,y), (0,0,255),20)
			time.sleep(0.025)						

cv2.setMouseCallback('image',draw_line)

while(1):
	cv2.imshow('image',img)
	k = cv2.waitKey(1) & 0xFF
	if k == ord('m'):
		crop_count=0
		mode = not mode
		print "mode change"
	elif k == ord('s'):
		with open('data.txt', 'w') as outfile:
			json.dump(lines, outfile)
	elif k == 27:
		break

cv2.destroyAllWindows()
