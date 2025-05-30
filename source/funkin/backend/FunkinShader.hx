package funkin.backend;

import flixel.addons.system.macros.FlxRuntimeShaderMacro;

/**
 * Modified runtime shader to prevent crashes.
 */
class FunkinRuntimeShader extends flixel.addons.display.FlxRuntimeShader
{
	override function __createGLProgram(vertexSource:String, fragmentSource:String):lime.graphics.opengl.GLProgram
	{
		try
		{
			return super.__createGLProgram(vertexSource, fragmentSource);
		}
		catch (error)
		{
			CoolUtil.doPopUp('Shader Crash!', error.toString());
			@:privateAccess return super.__createGLProgram(vertexSource, FunkinShader._templateFrag);
		}
	}
}

/**
 * Modified runtime shader to prevent crashes.
 */
class FunkinShader extends flixel.graphics.tile.FlxGraphicsShader
{
	override function __createGLProgram(vertexSource:String, fragmentSource:String):lime.graphics.opengl.GLProgram
	{
		try
		{
			return super.__createGLProgram(vertexSource, fragmentSource);
		}
		catch (error)
		{
			CoolUtil.doPopUp('Shader Crash!', error.toString());
			
			return super.__createGLProgram(vertexSource, _templateFrag);
		}
	}
	
	public function toString()
	{
		return 'FunkinShader';
	}
	
	/**
		fallback fragment shader to be used in case of error
	**/
	static final _templateFrag:String = FlxRuntimeShaderMacro.retrieveMetadata('glFragmentHeader')
		+ "
		void main() 
        {
			gl_FragColor = flixel_texture2D(bitmap, openfl_TextureCoordv);
		}

    ";
}
