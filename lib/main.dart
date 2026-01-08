import 'package:auto_rich_text/auto_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    );

    theme = theme.copyWith(textTheme: GoogleFonts.robotoMonoTextTheme(theme.textTheme));
    return MaterialApp(
      title: 'AutoRichText Demo',
      theme: theme,
      home: const HomePage(title: 'AutoRichText Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  final TextStyle _textStyle = const TextStyle(
    fontSize: 14,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        centerTitle: false,
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          alignment: Alignment.topLeft,
          child: SelectionArea(
            child: AutoRichText(
              text: _text,
              style: _textStyle,
              escape: true,
              onRefCallback: _onRef,
              onEventCallback: _onEvent,
              builder: (span, style) => Text.rich(span, style: style),
            ),
          ),
        ),
      ),
    );
  }

  TextSpan _onRef(String ref, TextStyle style) {
    return TextSpan(
      text: "Ref is $ref",
      style: style.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

  void _onEvent(AutoRichTextEvent evt) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text("Type: ${evt.type}\nId: ${evt.id}\nArgs: ${evt.args}"),
          ),
        ),
      ),
    );
  }

  String get _text {
    return """
<color=green># &lt;bold&gt;Bold Text&lt;/bold&gt;</color>
<color=green># &lt;weight=w700&gt;Bold&lt;/weight&gt;</color>
<bold>Bold Text</bold>
<weight=w900>Extra Bold</weight>
<weight=w300>Light Weight</weight>

<color=green># &lt;italic&gt;Italic Text&lt;/italic&gt;</color>
<italic>Italic Text</italic>

<color=green># &lt;color=#4C5A79&gt;Colored Text&lt;/color&gt;</color>
<color=green># &lt;color=orange&gt;Named Text&lt;/color&gt;</color>
<color=#4C5A79>Colored Text</color>
<color=orange>Named Color</color>

<color=green># &lt;size=20&gt;Large Text&lt;/size&gt;</color>
<color=green># &lt;size=+2&gt;Increased Size&lt;/size&gt;</color>
<color=green># &lt;size=-2&gt;Decreased Size&lt;/size&gt;</color>
<size=20>Large Text</size>
<size=+2>Increased Size</size>
<size=-2>Decreased Size</size>

<color=green># &lt;color=#FFF&gt;&lt;gradient='colors:red,yellow'&gt;Linear Gradient&lt;/gradient&gt;&lt;/color&gt;</color>
<color=green># &lt;color=#FFF&gt;&lt;gradient='colors:blue,purple,pink; type:linear'&gt;Multi-color Gradient&lt;/gradient&gt;&lt;/color&gt;</color>
<color=green># &lt;color=#FFF&gt;&lt;gradient='colors:cyan,lime; type:radial; radius:0.8'&gt;Radial Gradient&lt;/gradient&gt;&lt;/color&gt;</color>
<color=#FFF><gradient='colors:red,yellow'>Linear Gradient</gradient></color>
<color=#FFF><gradient='colors:blue,purple,pink; type:linear'>Multi Color Gradient</gradient></color>
<color=#FFF><gradient='colors:cyan,lime; type:radial; radius:0.8'>Radial Gradient</gradient></color>

<color=green># &lt;icon='code:0xE800; font-family:Icon'/&gt;</color>
<color=green># &lt;image='file:img_example.png; width:32; height:32'/&gt;</color>
<icon='code:0xE800; font-family:Icon'/>
<image='file:img_example.png; width:32; height:32'/>

<color=green># &lt;font=Borel&gt;Borel Font&lt;/font&gt;</color>
<font=Borel>Borel Font</font>

<color=green># &lt;delete=#FF0000&gt;Red Strikethrough&lt;/delete&gt;</color>
<color=green># &lt;delete='color:blue; style:dashed; thickness:2.0'&gt;Custom Strikethrough&lt;/delete&gt;</color>
<color=green># &lt;u=#FF0000&gt;Red Underline&lt;/u&gt;</color>
<color=green># &lt;u='color:orange; style:wavy; thickness:1.5'&gt;Wavy Underline&lt;/u&gt;</color>
<delete=#FF0000>Red Strikethrough</delete>
<delete='color:blue; style:dashed; thickness:2.0'>Custom Strikethrough</delete>
<u=#FF0000>Red Underline</u>
<u='color:orange; style:wavy; thickness:1.5'>Wavy Underline</u>

<color=green># &lt;click='id:click'&gt;Clickable Text&lt;/click&gt;</color>
<color=green># &lt;click='id:double; type:double'&gt;Double Click&lt;/click&gt;</color>
<color=green># &lt;click='id:long; type:long; args:a,b'&gt;Long Press with Args&lt;/click&gt;</color>
<color=green># &lt;tap='id:tap; types:tap'&gt;Tap Text&lt;/tap&gt;</color>
<color=green># &lt;ref=custom/&gt;</color>
<click='id:click'>Clickable Text</click>
<click='id:double; type:double'>Double Click</click>
<click='id:long; type:long; args:a,b'>Long Press with Args</click>
<tap='id:tap; types:tap'>Tap Text</tap>
<ref=custom/>

<color=green># &lt;bold&gt;&lt;italic&gt;&lt;color=#FF5722&gt;Bold Italic Orange&lt;/color&gt;&lt;/italic&gt;&lt;/bold&gt;</color>
<color=green># &lt;size=18&gt;&lt;weight=w600&gt;&lt;u=blue&gt;Large Bold Blue Underline&lt;/u&gt;&lt;/weight&gt;&lt;/size&gt;</color>
<bold><italic><color=#FF5722>Bold Italic Orange</color></italic></bold>
<size=18><weight=w600><u=blue>Large Bold Blue Underline</u></weight></size>
""";
  }
}
