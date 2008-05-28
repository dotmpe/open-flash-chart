﻿package ChartObjects {
	//import caurina.transitions.Tweener;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ChartObjects.Elements.Element;
	import ChartObjects.Elements.PointDot;
	import string.Utils;
	import flash.display.BlendMode;
	
	public class LineDot extends BaseLine
	{
		
		public function LineDot( json:Object )
		{
			
			this.style = {
				values:			[],
				width:			2,
				colour:			'#3030d0',
				text:			'',		// <-- default not display a key
				'dot-size':		5,
				'font-size':	12
			};
			
			object_helper.merge_2( json, style );
			
			this.style.colour = string.Utils.get_colour( this.style.colour );
			
			this.key = style.text;
			this.font_size = style['font-size'];
			
//			this.axis = which_axis_am_i_attached_to(data, num);
			tr.ace( name );
			tr.ace( 'axis : ' + this.axis );
				
//			this.make_highlight_dot();
			this.values = style['values'];
			this.set_links( null );
//			this.set_links( data['links'+append] );
			this.make();
			
			//
			// this allows the dots to erase part of the line
			//
			this.blendMode = BlendMode.LAYER;
			
//			this.set_links( lv['links'+name] );
//			this.set_tooltips( lv['tool_tips_set'+name] );
		}
		
		
		//
		// called from the BaseLine object
		//
		protected override function get_element( x:Number, value:Object ): Element {
			return new PointDot( x, value, this.style['dot-size'], this.style.colour );
		}
	}
}