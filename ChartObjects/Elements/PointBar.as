package ChartObjects.Elements {
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.flashdevelop.utils.FlashConnect;
	
	public class PointBar extends PointBarBase {
	
		public function PointBar( index:Number, style:Object, group:Number ) {
			
			//elskwid [links]
			// FIXME: Need to call links here
			super(index, style, style.colour, style.tip, group, '');
		}
		
		public override function resize( sc:ScreenCoords, axis:Number ):void {
			
			var h:Object = this.resize_helper( sc, axis );
			
			this.graphics.clear();
			this.graphics.beginFill( this.colour, 1.0 );
			this.graphics.moveTo( 0, 0 );
			this.graphics.lineTo( h.width, 0 );
			this.graphics.lineTo( h.width, h.height );
			this.graphics.lineTo( 0, h.height );
			this.graphics.lineTo( 0, 0 );
			this.graphics.endFill();
		}
		
	}
}