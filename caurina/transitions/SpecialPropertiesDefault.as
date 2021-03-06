﻿package caurina.transitions {

	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.media.SoundTransform;
	import flash.display.DisplayObject
	import flash.filters.ColorMatrixFilter
	import flash.text.*

	/**
	 * SpecialPropertiesDefault
	 * List of default special properties for the Tweener class
	 * The function names are strange/inverted because it makes for easier debugging (alphabetic order). They're only for internal use (on this class) anyways.
	 *
	 * @author		Zeh Fernando, Nate Chatellier
	 * @version		1.0.1
	 * @private
	 */

	public class SpecialPropertiesDefault {
		
		private static var __glowColour:Number = 0xFF0000;
		private static var __glowKnockout:Boolean = false;
		private static var __glowInner:Boolean = false;
		private static var __dropShadowColour:Number = 0x000000;
		private static var __dropShadowAngle:Number = 45;
		private static var __dropShadowInner:Boolean = false;
		private static var __quality:int = 1;
		
		/**
		 * There's no constructor.
		 */
		public function SpecialPropertiesDefault () {
			trace ("SpecialProperties is a static class and should not be instantiated.")
		}
	
		/**
		 * Registers all the special properties to the Tweener class, so the Tweener knows what to do with them.
		 */
		public static function init():void {

			// Normal properties
			Tweener.registerSpecialProperty("_frame", frame_get, frame_set);
			Tweener.registerSpecialProperty("_sound_volume", _sound_volume_get, _sound_volume_set);
			Tweener.registerSpecialProperty("_sound_pan", _sound_pan_get, _sound_pan_set);
			Tweener.registerSpecialProperty("_color_ra", _color_property_get, _color_property_set, ["redMultiplier"]);
			Tweener.registerSpecialProperty("_color_rb", _color_property_get, _color_property_set, ["redOffset"]);
			Tweener.registerSpecialProperty("_color_ga", _color_property_get, _color_property_set, ["greenMultiplier"]);
			Tweener.registerSpecialProperty("_color_gb", _color_property_get, _color_property_set, ["greenOffset"]);
			Tweener.registerSpecialProperty("_color_ba", _color_property_get, _color_property_set, ["blueMultiplier"]);
			Tweener.registerSpecialProperty("_color_bb", _color_property_get, _color_property_set, ["blueOffset"]);
			Tweener.registerSpecialProperty("_color_aa", _color_property_get, _color_property_set, ["alphaMultiplier"]);
			Tweener.registerSpecialProperty("_color_ab", _color_property_get, _color_property_set, ["alphaOffset"]);
			
			//ADDED BY CHESTER RIVAS 2007
			
			Tweener.registerSpecialProperty("_autoAlpha", _autoAlpha_get, _autoAlpha_set);
			// color brightness
			Tweener.registerSpecialProperty("_brightness", __brightness_get, __brightness_set);
			// color contrast
			Tweener.registerSpecialProperty("_contrast", __contrast_get, __contrast_set);
			// color saturation
			Tweener.registerSpecialProperty("_saturation", __saturation_get, __saturation_set);
			
			// Scrolling properties
			Tweener.registerSpecialProperty("_horizontalTextScroll", _xTextScroll_get, _xTextScroll_set );
			Tweener.registerSpecialProperty("_verticalTextScroll", _yTextScroll_get, _yTextScroll_set );
			
			// Normal splitter properties
			Tweener.registerSpecialPropertySplitter("_color", _color_splitter);
			Tweener.registerSpecialPropertySplitter("_colorTransform", _colorTransform_splitter);
			
			// Scale splitter properties
			Tweener.registerSpecialPropertySplitter("_scale", _scale_splitter);
			
			// Filter tweening properties - BlurFilter
			Tweener.registerSpecialProperty("_blur_blurX", _filter_property_get, _filter_property_set, [BlurFilter, "blurX"]);
			Tweener.registerSpecialProperty("_blur_blurY", _filter_property_get, _filter_property_set, [BlurFilter, "blurY"]);
			Tweener.registerSpecialProperty("_blur_quality", _filter_property_get, _filter_property_set, [BlurFilter, "quality"]);
			
			// Filter tweening properties - DropShadowFilter
			Tweener.registerSpecialProperty("_dropshadow_blurX", _filter_property_get, _filter_property_set, [DropShadowFilter, "blurX"]);
			Tweener.registerSpecialProperty("_dropshadow_blurY", _filter_property_get, _filter_property_set, [DropShadowFilter, "blurY"]);
			Tweener.registerSpecialProperty("_dropshadow_distance", _filter_property_get, _filter_property_set, [DropShadowFilter, "distance"]);
			Tweener.registerSpecialProperty("_dropshadow_alpha", _filter_property_get, _filter_property_set, [DropShadowFilter, "alpha"]);
			Tweener.registerSpecialProperty("_dropshadow_strength", _filter_property_get, _filter_property_set, [DropShadowFilter, "strength"]);
			Tweener.registerSpecialProperty("_dropshadow_angle", _filter_property_get, _filter_property_set, [DropShadowFilter, "angle"]);
			
			// Filter tweening properties - GlowFilter
			Tweener.registerSpecialProperty("_glow_blurX", _filter_property_get, _filter_property_set, [GlowFilter, "blurX"]);
			Tweener.registerSpecialProperty("_glow_blurY", _filter_property_get, _filter_property_set, [GlowFilter, "blurY"]);
			Tweener.registerSpecialProperty("_glow_alpha", _filter_property_get, _filter_property_set, [GlowFilter, "alpha"]);
			Tweener.registerSpecialProperty("_glow_strength", _filter_property_get, _filter_property_set, [GlowFilter, "strength"]);
			
			// Filter tweening splitter properties
			Tweener.registerSpecialPropertySplitter("_filter", _filter_splitter);
			
			// Bezier modifiers
			Tweener.registerSpecialPropertyModifier("_bezier", _bezier_modifier, _bezier_get);

			
		}
		
		// ----------------------------------------------------------------------------------------------------------------------------------
		// textScrolling*

		public static function _xTextScroll_get (p_obj:*):Number 
		{
			return p_obj.scrollH;
		};

		public static function _xTextScroll_set (p_obj:*, p_value:Number):void 
		{
			p_obj.scrollH = p_value;
		};
		
		public static function _yTextScroll_get (p_obj:*):Number 
		{
			return p_obj.scrollV;
		};

		public static function _yTextScroll_set (p_obj:*, p_value:Number):void 
		{
			p_obj.scrollV = p_value;
		};
		
		// ----------------------------------------------------------------------------------------------------------------------------------
		// _brightness_*

		/**
		 * Gets brightness using ColorMatrix
		 *
		 * @param		p_obj				DisplayObject	A Display Object instance
		 * @return							Number			Value of the brightness property
		 */		
		public static function __brightness_get (p_obj: DisplayObject):Number 
		{
			return getColorMatrix(p_obj).getBrightness();
		};

		/**
		 * Changes brightness of a DisplayObject using ColorMatrix
		 *
		 * @param		p_obj				DisplayObject	A Display Object instance
		 * @param		p_value				Number			Value of the brightness property (min: -100 / max: 100 / standard: 0)
		 */	
		public static function __brightness_set (p_obj:DisplayObject, p_value:Number):void 
		{
			var colorMatrix: ColorMatrix = new ColorMatrix();
			colorMatrix.setBrightness(p_value);
			setColorMatrix(p_obj, colorMatrix);
		};

		// ----------------------------------------------------------------------------------------------------------------------------------
		// _contrast_*
		/**
		 * Gets contrast using ColorMatrix
		 *
		 * @param		p_obj				DisplayObject	A Display Object instance
		 * @return							Number			Value of the contrast property
		 */			
		public static function __contrast_get (p_obj: DisplayObject):Number 
		{
			return getColorMatrix(p_obj).getContrast();
		};

		/**
		 * Changes contrast of a DisplayObject using ColorMatrix
		 *
		 * @param		p_obj				DisplayObject	A Display Object instance
		 * @param		p_value				Number			Value of the contrast property (min: -200 / max: 500 / standard: 0)
		 */	
		public static function __contrast_set (p_obj:DisplayObject, p_value:Number):void 
		{
			var colorMatrix: ColorMatrix = new ColorMatrix();
			colorMatrix.setContrast(p_value);
			setColorMatrix(p_obj, colorMatrix);
		};

		// ----------------------------------------------------------------------------------------------------------------------------------
		// _saturation_*
		/**
		 * Gets saturation using ColorMatrix
		 *
		 * @param		p_obj				DisplayObject	A Display Object instance
		 * @return							Number			Value of the saturation property
		 */			
		public static function __saturation_get (p_obj: DisplayObject):Number 
		{
			return getColorMatrix(p_obj).getSaturation();
		};

		/**
		 * Changes saturation of a DisplayObject using ColorMatrix
		 *
		 * @param		p_obj				DisplayObject	A Display Object instance
		 * @param		p_value				Number			Value of the saturation property (min: -300 / max: 300 / standard: 100)
		 */	
		public static function __saturation_set (p_obj:DisplayObject, p_value:Number):void 
		{
			var colorMatrix: ColorMatrix = new ColorMatrix();
			colorMatrix.setSaturation(p_value);
			setColorMatrix(p_obj, colorMatrix);
		};


		// ----------------------------------------------------------------------------------------------------------------------------------
		// COLORMATRIX helper functions -----------------------------------------------------------------------------------------------------

		/**
		 * Helper method for getting the ColorMatrix of a DisplayObject
		 *
		 * @param		p_obj				DisplayObject	A Display Object instance
		 * @return							ColorMatrix		ColorMatrix of the Display Object 
		 */				
		private static function getColorMatrix(p_obj: DisplayObject):ColorMatrix
		{
			var filters: Array = p_obj.filters;
			var colorMatrix:ColorMatrix = new ColorMatrix();

			var i:int = filters.length;
			
			while(--i > -1)
			{
				if(filters[i] is ColorMatrixFilter)
				{
					colorMatrix.matrix = filters[i].matrix.concat();
					break;
				}				
			}			
			return colorMatrix;
		}

		/**
		 * Helper method for setting the ColorMatrix of a DisplayObject
		 *
		 * @param		p_obj				DisplayObject	A Display Object instance
		 * @param		p_value				ColorMatrix		A ColorMatrix instance
		 */	
		private static function setColorMatrix(p_obj: DisplayObject, value: ColorMatrix): void
		{
			var filters: Array = p_obj.filters;
			var tFilters: Array = new Array();
			var colorMatrix: ColorMatrix = value;

			var i:int = filters.length;
			
			while(--i > -1)
			{
				if(!(filters[i] is ColorMatrixFilter))
				{
					tFilters.push(filters[i]);
				}				
			}
			
			tFilters.push(colorMatrix.filter);
			p_obj.filters = tFilters;

		}
	

		// ==================================================================================================================================
		// PROPERTY GROUPING/SPLITTING functions --------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------------------------------------
		// _color

		/**
		 * Splits the _color parameter into specific color variables
		 *
		 * @param		p_value				Number		The original _color value
		 * @return							Array		An array containing the .name and .value of all new properties
		 */
		public static function _color_splitter (p_value:*):Array {
			var nArray:Array = new Array();
			if (p_value == null) {
				// No parameter passed, so just resets the color
				nArray.push({name:"_color_ra", value:1});
				nArray.push({name:"_color_rb", value:0});
				nArray.push({name:"_color_ga", value:1});
				nArray.push({name:"_color_gb", value:0});
				nArray.push({name:"_color_ba", value:1});
				nArray.push({name:"_color_bb", value:0});
			} else {
				// A color tinting is passed, so converts it to the object values
				nArray.push({name:"_color_ra", value:0});
				nArray.push({name:"_color_rb", value:AuxFunctions.numberToR(p_value)});
				nArray.push({name:"_color_ga", value:0});
				nArray.push({name:"_color_gb", value:AuxFunctions.numberToG(p_value)});
				nArray.push({name:"_color_ba", value:0});
				nArray.push({name:"_color_bb", value:AuxFunctions.numberToB(p_value)});
			}
			return nArray;
		}


		// ----------------------------------------------------------------------------------------------------------------------------------
		// _colorTransform

		/**
		 * Splits the _colorTransform parameter into specific color variables
		 *
		 * @param		p_value				Number		The original _colorTransform value
		 * @return							Array		An array containing the .name and .value of all new properties
		 */
		public static function _colorTransform_splitter (p_value:*):Array {
			var nArray:Array = new Array();
			if (p_value == null) {
				// No parameter passed, so just resets the color
				nArray.push({name:"_color_ra", value:1});
				nArray.push({name:"_color_rb", value:0});
				nArray.push({name:"_color_ga", value:1});
				nArray.push({name:"_color_gb", value:0});
				nArray.push({name:"_color_ba", value:1});
				nArray.push({name:"_color_bb", value:0});
			} else {
				// A color tinting is passed, so converts it to the object values
				if (p_value.ra != undefined) nArray.push({name:"_color_ra", value:p_value.ra});
				if (p_value.rb != undefined) nArray.push({name:"_color_rb", value:p_value.rb});
				if (p_value.ga != undefined) nArray.push({name:"_color_ba", value:p_value.ba});
				if (p_value.gb != undefined) nArray.push({name:"_color_bb", value:p_value.bb});
				if (p_value.ba != undefined) nArray.push({name:"_color_ga", value:p_value.ga});
				if (p_value.bb != undefined) nArray.push({name:"_color_gb", value:p_value.gb});
				if (p_value.aa != undefined) nArray.push({name:"_color_aa", value:p_value.aa});
				if (p_value.ab != undefined) nArray.push({name:"_color_ab", value:p_value.ab});
			}
			return nArray;
		}


		// ----------------------------------------------------------------------------------------------------------------------------------
		// scale
		public static function _scale_splitter(p_value:Number) : Array{
			var nArray:Array = new Array();
			nArray.push({name:"scaleX", value: p_value});
			nArray.push({name:"scaleY", value: p_value});
			return nArray;
		}


		// ----------------------------------------------------------------------------------------------------------------------------------
		// filters

		/**
		 * Splits the _filter, _blur, etc parameter into specific filter variables
		 *
		 * @param		p_value				BitmapFilter	A BitmapFilter instance
		 * @return							Array			An array containing the .name and .value of all new properties
		 */
		public static function _filter_splitter (p_value:BitmapFilter):Array {
			var nArray:Array = new Array();
			if (p_value is BlurFilter) {
				nArray.push({name:"_blur_blurX",		value:BlurFilter(p_value).blurX});
				nArray.push({name:"_blur_blurY",		value:BlurFilter(p_value).blurY});
				nArray.push({name:"_blur_quality",		value:BlurFilter(p_value).quality});
			} else {
				// ?
				trace ("??");
			}
			return nArray;
		}

		// ==================================================================================================================================
		// NORMAL SPECIAL PROPERTY functions ------------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------------------------------------
		// _frame
	
		/**
		 * Returns the current frame number from the movieclip timeline
		 *
		 * @param		p_obj				Object		MovieClip object
		 * @return							Number		The current frame
		 */
		public static function frame_get (p_obj:Object):Number {
			return p_obj.currentFrame;
		}
	
		/**
		 * Sets the timeline frame
		 *
		 * @param		p_obj				Object		MovieClip object
		 * @param		p_value				Number		New frame number
		 */
		public static function frame_set (p_obj:Object, p_value:Number):void {
			p_obj.gotoAndStop(Math.round(p_value));
		}
	
		
		// ----------------------------------------------------------------------------------------------------------------------------------
		// _sound_volume
	
		/**
		 * Returns the current sound volume
		 *
		 * @param		p_obj				Object		Sound object
		 * @return							Number		The current volume
		 */
		public static function _sound_volume_get (p_obj:Object):Number {
			return p_obj.soundTransform.volume;
		}
	
		/**
		 * Sets the sound volume
		 *
		 * @param		p_obj				Object		Sound object
		 * @param		p_value				Number		New volume
		 */
		public static function _sound_volume_set (p_obj:Object, p_value:Number):void {
			var sndTransform:SoundTransform = p_obj.soundTransform;
			sndTransform.volume = p_value;
			p_obj.soundTransform = sndTransform;
		}
	
	
		// ----------------------------------------------------------------------------------------------------------------------------------
		// _sound_pan
	
		/**
		 * Returns the current sound pan
		 *
		 * @param		p_obj				Object		Sound object
		 * @return							Number		The current pan
		 */
		public static function _sound_pan_get (p_obj:Object):Number {
			return p_obj.soundTransform.pan;
		}
	
		/**
		 * Sets the sound volume
		 *
		 * @param		p_obj				Object		Sound object
		 * @param		p_value				Number		New pan
		 */
		public static function _sound_pan_set (p_obj:Object, p_value:Number):void {
			var sndTransform:SoundTransform = p_obj.soundTransform;
			sndTransform.pan = p_value;
			p_obj.soundTransform = sndTransform;
		}


		// ----------------------------------------------------------------------------------------------------------------------------------
		// _color_*

		/**
		 * _color_*
		 * Generic function for the ra/rb/ga/gb/ba/bb/aa/ab components of the colorTransform object
		 */
		public static function _color_property_get (p_obj:Object, p_parameters:Array):Number {
			return p_obj.transform.colorTransform[p_parameters[0]];
		}
		public static function _color_property_set (p_obj:Object, p_value:Number, p_parameters:Array):void {
			var tf:ColorTransform = p_obj.transform.colorTransform;
			tf[p_parameters[0]] = p_value;
			p_obj.transform.colorTransform = tf;
		}


		// ----------------------------------------------------------------------------------------------------------------------------------
		// _autoAlpha
	
		/**
		 * Returns the current alpha
		 *
		 * @param		p_obj				Object		MovieClip or Textfield object
		 * @return							Number		The current alpha
		 */
		public static function _autoAlpha_get (p_obj:Object):Number {
			return p_obj.alpha;
		}
	
		/**
		 * Sets the current autoAlpha 
		 *
		 * @param		p_obj				Object		MovieClip or Textfield object
		 * @param		p_value				Number		New alpha
		 */
		public static function _autoAlpha_set (p_obj:Object, p_value:Number):void {
			p_obj.alpha = p_value;
			p_obj.visible = p_value > 0;
		}


		// ----------------------------------------------------------------------------------------------------------------------------------
		// filters

		/**
		 * (filters)
		 * Generic function for the properties of filter objects
		 */
		public static function _filter_property_get (p_obj:Object, p_parameters:Array):Number {
			var f:Array = p_obj.filters;
			var i:uint;
			var filterClass:Object = p_parameters[0];
			var propertyName:String = p_parameters[1];
			
			for (i = 0; i < f.length; i++) {
				if (f[i] is BlurFilter && filterClass == BlurFilter) return (f[i][propertyName]);
				if (f[i] is DropShadowFilter && filterClass == DropShadowFilter) return (f[i][propertyName]);
				if (f[i] is GlowFilter && filterClass == GlowFilter) return (f[i][propertyName]);
			}
			
			// No value found for this property - no filter instance found using this class!
			// Must return default desired values
			var defaultValues:Object;
			switch (filterClass) {
				case BlurFilter:
					defaultValues = {blurX:0, blurY:0, quality:NaN};
				break;
				case DropShadowFilter:
					defaultValues = {blurX:0, blurY:0, distance:0, alpha:0, strength:0, angle:45};
				break;
				case GlowFilter:
					defaultValues = {blurX:0, blurY:0, alpha:0, strength:0};
				break;
			}
			// When returning NaN, the Tweener engine sets the starting value as being the same as the final value
			// When returning null, the Tweener engine doesn't tween it at all, just setting it to the final value
			return defaultValues[propertyName];
		}

		public static function _filter_property_set (p_obj:Object, p_value:Number, p_parameters:Array): void {
			//trace("_filter_property_set: p_obj -- "+p_obj+", p_value -- "+p_value+", p_parameters -- "+p_parameters);
			var f:Array = p_obj.filters;
			var i:uint;
			var filterClass:Object = p_parameters[0];
			var propertyName:String = p_parameters[1];
			
			for (i = 0; i < f.length; i++) {
				if (f[i] is BlurFilter && filterClass == BlurFilter) {
					f[i][propertyName] = p_value;
					p_obj.filters = f;
					return;
				}
				if (f[i] is DropShadowFilter && filterClass == DropShadowFilter) {
					f[i][propertyName] = p_value;
					p_obj.filters = f;
					return;
				}
				if (f[i] is GlowFilter && filterClass == GlowFilter) {
					f[i][propertyName] = p_value;
					p_obj.filters = f;
					return;
				}
			}
			
			
			// The correct filter class wasn't found - create a new one
			if (f == null) f = new Array();
			// fi can be either the BlurFilter or the DropShadowFilter
			var fi:*;
			switch (filterClass) {
				case BlurFilter:
					fi = new BlurFilter( 0, 0, __quality );
				break;
				case DropShadowFilter:
					fi = new DropShadowFilter( 0, __dropShadowAngle, __dropShadowColour, 0, 0, 0, 0, __quality, __dropShadowInner );
				break;
				case GlowFilter:
					fi = new GlowFilter( __glowColour, 0, 0, 0, 0, __quality, __glowInner, __glowKnockout );
				break;
			}
			fi[propertyName] = p_value;
			f.push(fi);
			p_obj.filters = f;
			
		}
		
		//DEFAULT VALUE IS LOW IF YOU WANT TO MAKE IT HIGH or MEDIUM CHANGE IT via Tweener.filterQuality.
		public static function set setFilterQuality( qValue:int ):void {
			__quality = qValue;
		}
		
		//DEFAULT GLOW COLOUR IS 0xFF0000 (RED) __glowColour via Tweener.filterGlowColour
		public static function set glowColour( colourValue:Number ):void {
			__glowColour = colourValue;
		}
		
		//DEFAULT FOR INNER IS FALSE via Tweener.filterGlowInner
		public static function set glowInner( ib:Boolean ):void {
			__glowInner = ib;
		}
		
		//DEFAULT FOR KNOCKOUT IS FALSE | CHANGE via Tweener.filterGlowKnockout
		public static function set glowKnockout( kb:Boolean ):void {
			__glowKnockout = kb;
		}
		
		//DEFAULT FOR SHADOW COLOUR IS 0x000000 (BLACK) | CHANGE via Tweener.filterDropShadowColour
		public static function set shadowColour( colourValue:Number ):void {
			__dropShadowColour = colourValue;
		}
		
		//DEFAULT FOR SHADOW COLOUR IS 0x000000 (BLACK) | CHANGE via Tweener.filterDropShadowColour
		public static function set shadowAngle( angleValue:Number ):void {
			__dropShadowAngle = angleValue;
		}
		
		//DEFAULT FOR SHADOW COLOUR IS 0x000000 (BLACK) | CHANGE via Tweener.filterDropShadowColour
		public static function set shadowInner( iShadow:Boolean ):void {
			__dropShadowInner = iShadow;
		}
		
		
		// ==================================================================================================================================
		// SPECIAL PROPERTY MODIFIER functions ----------------------------------------------------------------------------------------------
		// ----------------------------------------------------------------------------------------------------------------------------------
		// _bezier

		/**
		 * Given the parameter object passed to this special property, return an array listing the properties that should be modified, and their parameters
		 *
		 * @param		p_obj				Object		Parameter passed to this property
		 * @return							Array		Array listing name and parameter of each property
		 */
		public static function _bezier_modifier (p_obj:*):Array {
			var mList:Array = []; // List of properties to be modified
			var pList:Array; // List of parameters passed, normalized as an array
			if (p_obj is Array) {
				// Complex
				pList = p_obj;
			} else {
				pList = [p_obj];
			}

			var i:uint;
			var istr:String;
			var mListObj:Object = {}; // Object describing each property name and parameter

			for (i = 0; i < pList.length; i++) {
				for (istr in pList[i]) {
					if (mListObj[istr] == undefined) mListObj[istr] = [];
					mListObj[istr].push(pList[i][istr]);
				}
			}
			for (istr in mListObj) {
				mList.push({name:istr, parameters:mListObj[istr]});
			}
			return mList;
		}

		/**
		 * Given tweening specifications (beging, end, t), applies the property parameter to it, returning new t
		 *
		 * @param		b					Number		Beginning value of the property
		 * @param		e					Number		Ending (desired) value of the property
		 * @param		t					Number		Current t of this tweening (0-1), after applying the easing equation
		 * @param		p					Array		Array of parameters passed to this specific property
		 * @return							Number		New t, with the p parameters applied to it
		 */
		public static function _bezier_get (b:Number, e:Number, t:Number, p:Array):Number {
			// This is based on Robert Penner's code
			if (p.length == 1) {
				// Simple curve with just one bezier control point
				return b + t*(2*(1-t)*(p[0]-b) + t*(e - b));
			} else {
				// Array of bezier control points, must find the point between each pair of bezier points
				var ip:uint = Math.floor(t * p.length); // Position on the bezier list
				var it:Number = (t - (ip * (1 / p.length))) * p.length; // t inside this ip
				var p1:Number, p2:Number;
				if (ip == 0) {
					// First part: belongs to the first control point, find second midpoint
					p1 = b;
					p2 = (p[0]+p[1])/2;
				} else if (ip == p.length - 1) {
					// Last part: belongs to the last control point, find first midpoint
					p1 = (p[ip-1]+p[ip])/2;
					p2 = e;
				} else {
					// Any middle part: find both midpoints
					p1 = (p[ip-1]+p[ip])/2;
					p2 = (p[ip]+p[ip+1])/2;
				}
				return p1+it*(2*(1-it)*(p[ip]-p1) + it*(p2 - p1));
			}
		}

	}
}