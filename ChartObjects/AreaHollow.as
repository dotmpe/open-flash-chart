﻿package ChartObjects {
	import ChartObjects.Elements.Element;
	import ChartObjects.Elements.PointHollow;
	import string.Utils;
	import flash.display.BlendMode;
	
	public class AreaHollow extends BaseLine {
		private var fill_colour:Number;
		private var fill_alpha:Number;
		
		public function AreaHollow( json:Object ) {
			
			var style:Object = {
				values: [],
				width: 2,
				colour: '#3030d0',
				fill: '',
				text: '',		// <-- default not display a key
				'dot-size': 5,
				'font-size': 12,
				'fill-alpha': 0.6
			};
			
			object_helper.merge_2( json, style );
			
			this.line_width = style.width;;
			this.circle_size = style['dot-size'];
			this.fill_alpha =  style['fill-alpha'];
				
			this.colour = string.Utils.get_colour( style.colour );
			if( style.fill == '' )
				style.fill = style.colour;
				
			this.fill_colour = string.Utils.get_colour( style.fill );
			
			this.key = style.text;
			this.font_size = style['font-size'];
			this.values = style['values'];
			this.set_links( null );
			this.make();
		}
		
		//
		// called from the base object
		//
		protected override function get_element( index:Number, value:Object ): Element {
			return new ChartObjects.Elements.PointHollow( index, value, this.circle_size, this.colour );
		}
		
		public override function resize(sc:ScreenCoords):void {
			
			// now draw the line + hollow dots
			super.resize(sc);
						
			var x:Number;
			var y:Number;
			var last:PointHollow;
			var first:Boolean = true;
			
			for ( var i:Number = 0; i < this.numChildren; i++ ) {
				var e:PointHollow = this.getChildAt(i) as PointHollow;
				
				// tell the point where it is on the screen
				// we will use this info to place the tooltip
				x = sc.get_x_from_pos(e._x);
				y = sc.get_y_from_val(e._y);
				if( first )
				{
					// draw line from Y=0 up to Y pos
					this.graphics.moveTo( x, sc.get_y_bottom(false) );
					this.graphics.lineStyle(0,0,0);
					this.graphics.beginFill( this.fill_colour, this.fill_alpha );
					this.graphics.lineTo( x, y );
					first = false;
				}
				else
				{
					this.graphics.lineTo( x, y );
					last = e;
				}
			}
			
			if( last != null )
				this.graphics.lineTo( sc.get_x_from_pos(last._x), sc.get_y_bottom(false) );
				
			this.graphics.endFill();
		}
	}
}