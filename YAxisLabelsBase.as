﻿package {
	import flash.display.Sprite;
	import TextFieldY;
	import flash.text.TextFormat;
	import org.flashdevelop.utils.FlashConnect;
	
	public class YAxisLabelsBase extends Sprite {
		private var steps:Number;
		private var right:Boolean;
		
		public function YAxisLabelsBase( values:Array, steps:Number, json:Object, name:String, style_name:String ) {

			this.steps = steps;
			
			var style:YLabelStyle = new YLabelStyle( json, name );
			
			// are the Y Labels visible?
			if( !style.show_labels )
				return;
				
			// labels
			var pos:Number = 0;
			
			for each ( var v:Object in values )
			{
				var tmp:TextFieldY = this.make_label( v.val, style );
				tmp.y_val = v.pos;
				this.addChild(tmp);
				
				pos++;
			}
		}

		//
		// use Y Min, Y Max and Y Steps to create an array of
		// Y labels:
		//
		protected function make_labels( m:MinMax, right:Boolean, steps:Number ):Array {
			var values:Array = [];
			
			var min:Number = Math.min( m.get_y_min(right), m.get_y_max(right) );
			var max:Number = Math.max( m.get_y_min(right), m.get_y_max(right) );
			
			var every:Number = (max - min) / steps;
			
			tr.ace('every ' + every);
			tr.ace('min ' + min);
			tr.ace('min ' + m.get_y_min(right));
			tr.ace('min ' + m.get_y_max(right));
			
			for( var i:Number = min; i <= max; i++ ) {
				
				tr.ace(i);
				tr.ace(i % every == 0);
				if( i % every == 0 )
				{
					// TODO: number format i
					values.push( { val:i, pos:i } );
					tr.ace(i);
				}
			}
			return values;
		}
		
		private function make_label( title:String, style:YLabelStyle ):TextFieldY
		{
			
			
			// does _root already have this textFiled defined?
			// this happens when we do an AJAX reload()
			// these have to be deleted by hand or else flash goes wonky.
			// In an ideal world we would put this code in the object
			// distructor method, but I don't think actionscript has these :-(

			
			var tf:TextFieldY = new TextFieldY();
			//tf.border = true;
			tf.text = title;
			var fmt:TextFormat = new TextFormat();
			fmt.color = style.colour;
			fmt.font = "Verdana";
			fmt.size = style.size;
			fmt.align = "right";
			tf.setTextFormat(fmt);
			tf.autoSize="right";
			return tf;
		}

		// move y axis labels to the correct x pos
		public function resize( left:Number, sc:ScreenCoords ):void
		{
		}


		public function get_width():Number{
			var max:Number = 0;
			for( var i:Number=0; i<this.numChildren; i++ )
			{
				var tf:TextFieldY = this.getChildAt(i) as TextFieldY;
				max = Math.max( max, tf.width );
			}
			return max;
		}
	}
}