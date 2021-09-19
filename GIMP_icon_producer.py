#!/usr/bin/env python
# documentation : 
# https://stuff.mit.edu/afs/sipb/project/gimp-2.2/src/gimp-2.2.11/plug-ins/pygimp/doc/pygimp.html#LAYER-OBJECT
# https://developer.gimp.org/api/2.0/libgimp/libgimp-gimpcontext.html
# Script for The Gimp
# this script is ment to iterate over all the layouts and reduce the images to generate icons of the colors listed in the prompt.

from gimpfu import *
def jtb_script_icons(image, layer, iconHeight, select_color, dir, colorNames,colorValues) : #FUNCTION DEFINITION
	
	keys=colorNames.split(";")
	values=colorValues.split(";")
	colorDict=dict(zip(keys, values))
	#pdb.gimp_message(colorDict)
		
	for colorName in colorDict:
		h = colorDict.get(colorName).lstrip('#')
		colorDict[colorName]=tuple(int(h[i:i+2], 16) for i in (0, 2, 4))
	
	for currentLayer in image.layers:
		for colorName in colorDict:
			newColor = colorDict[colorName]
					
			#copy selected layer to a new image and display
			pdb.gimp_edit_copy(currentLayer)
			newImage = pdb.gimp_edit_paste_as_new_image()
			newLayer = pdb.gimp_image_get_active_layer(newImage)
			display = gimp.Display(newImage)
			
			#autocrop new image
			pdb.plug_in_autocrop(newImage, newLayer)
			
			#scale image
			width = pdb.gimp_image_width(newImage)
			heigth = pdb.gimp_image_height(newImage)		
			newWidth=round((width*iconHeight)/heigth)
			pdb.gimp_image_scale_full(newImage, newWidth, iconHeight, INTERPOLATION_CUBIC)
						
			#select shape & clean on another layer
			pdb.gimp_selection_none(newImage)
			pdb.gimp_context_set_sample_threshold_int(120)
			pdb.gimp_context_set_antialias(TRUE)
			pdb.gimp_context_set_feather(FALSE)
			pdb.gimp_context_set_sample_merged(FALSE)
			pdb.gimp_context_set_sample_criterion(SELECT_CRITERION_A)
			pdb.gimp_context_set_sample_transparent(TRUE)
			pdb.gimp_image_select_color(newImage, CHANNEL_OP_REPLACE, newLayer, select_color)
			cleanLayer = pdb.gimp_layer_new(newImage, newWidth, iconHeight, RGBA_IMAGE, "clean", 100, LAYER_MODE_NORMAL_LEGACY)
			pdb.gimp_image_insert_layer(newImage, cleanLayer, None, 0);
			pdb.gimp_image_set_active_layer(newImage, newLayer)
			pdb.gimp_image_remove_layer(newImage, newLayer)
			
			#Fill selection with color
			gimp.set_foreground(newColor)
			pdb.gimp_edit_bucket_fill(cleanLayer, BUCKET_FILL_FG, LAYER_MODE_NORMAL_LEGACY, 100, 15, FALSE, -1, -1)	
			
			#save to png
			layername=pdb.gimp_item_get_name(currentLayer)
			filename= dir + layername + "_"+ str(int(iconHeight))+"_"+colorName+".png"
			pdb.file_png_save(newImage, cleanLayer, filename, filename, 0, 9, 1, 0, 0, 0, 1)
			
			#delete new image from memory
			pdb.gimp_display_delete(display)
			#pdb.gimp_image_delete(newImage)	
	
register(
	"jtb_script_icons",
	"JTB Icon Producer",
	"This script produces icons in batch",
	"Gautier Vanderslyen",
	"Gautier Vanderslyen",
	"27Apr2020",
	"<Image>/Python-Fu/JTB Icon Producer",
	"*",
	[ 
	#INPUT BEGINS
	(PF_SPINNER, "iconHeight", "Icon Height", 16.0, (0, 512, 8)),
	(PF_COLOR, "select_color", "Selection color", (255, 255, 255)),
	(PF_STRING, "dir", "Base dir to save", "C:\\Users\\vanderslyen.g\\Pictures\\" ),
	#(PF_STRING, "colorNames", "Color Names", "BLUE;DK_BLUE" ),
	#(PF_STRING, "colorValues", "Color Values", "#00AAFF;#0000FF" ),
	(PF_STRING, "colorNames", "Color Names", "WHITE;LT_GRAY;DK_GRAY;BLACK;RED;DK_RED;ORANGE;YELLOW;GREEN;DK_GREEN;BLUE;DK_BLUE;PURPLE;PINK" ),
	(PF_STRING, "colorValues", "Color Values", "#FFFFFF;#AAAAAA;#555555;#000000;#FF0000;#AA0000;#FF5500;FFAA00;#00FF00;#00AA00;#00AAFF;#0000FF;#AA00FF;#FF00FF" ),
	#PF_DIRNAME
	#INPUT ENDS
	],
	[],
	jtb_script_icons)

main()