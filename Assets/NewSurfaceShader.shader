Shader "Sbin/NewSurfaceShader" {
    Properties
    {
       _color("main color",color)=(1,1,1,1)
       _Ambient("Ambient",color)=(0.3,0.3,0.3,0.3)
       _Specular("specular",color)=(1,1,1,1)
       _shininess("Shininess",Range(0,8))=4
       _emission("Emission",color)=(1,1,1,1)
    }
	
	SubShader {
		pass{
         Material{
       
         diffuse [_color] //漫反射
         Ambient[_Ambient]//环境光
         SPECULAR[_Specular]//镜面
         Shininess[_shininess]//自发光
         Emission[_emission]
        
         }
         Lighting on 
         SeparateSpecular on
             }
}

}