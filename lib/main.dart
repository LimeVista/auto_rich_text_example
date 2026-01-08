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

  final TextEditingController _controller = TextEditingController(
    text: """
=== Text Styles ===
<bold>Bold Text</bold>
<italic>Italic Text</italic>
<color=#4C5A79>Colored Text</color>
<color=lime>Named Color</color>
<size=20>Large Text</size>
<size=+5>Increased Size</size>
<size=-3>Decreased Size</size>
<weight=w900>Extra Bold</weight>
<weight=w300>Light Weight</weight>
<font=sans>Sans Font</font>

=== Decoration Tags ===
<delete=#FF0000>Red Strikethrough</delete>
<delete='color:blue; style:dashed; thickness:2.0'>Custom Strikethrough</delete>
<u=#FF0000>Red Underline</u>
<u='color:orange; style:wavy; thickness:1.5'>Wavy Underline</u>

=== Gradient Tags ===
<gradient='colors:red,yellow'>Linear Gradient</gradient>
<gradient='colors:blue,purple,pink; type:linear'>Multi-color Gradient</gradient>
<gradient='colors:cyan,lime; type:radial; radius:0.8'>Radial Gradient</gradient>

=== Alignment Tags ===
<align=top>Top Aligned</align>
<align=middle>Middle Aligned</align>
<align=bottom>Bottom Aligned</align>

=== Interactive Tags ===
<click='id:link1'>Clickable Text</click>
<click='id:link2; type:double'>Double Click</click>
<click='id:link3; type:long; args:param1,param2'>Long Press with Args</click>
<tap='id:tap1; types:tap'>Tap Text</tap>
<tap='id:tap2; types:tapDown,tapUp'>Multi-type Touch</tap>

=== Placeholder Tags ===
<icon='code:66083; font-family:IconFont'/>
<image='file:ic_music.png; width:24; height:24'/>
<ref=custom/>

=== Combined Styles ===
<bold><italic><color=#FF5722>Bold Italic Orange</color></italic></bold>
<size=18><weight=w600><u=blue>Large Bold Blue Underline</u></weight></size>
<gradient='colors:gold,orange'><bold>Gradient Bold</bold></gradient>
""",
  );

  final TextStyle _textStyle = const TextStyle(
    fontSize: 14,
    color: Colors.black,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      body: Row(
        children: [
          Expanded(child: _buildPreview()),
          Container(width: 1, color: Colors.grey),
          Expanded(child: _buildEditor()),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(12),
        alignment: Alignment.topLeft,
        child: AutoRichText(
          text: _controller.text,
          style: _textStyle,
          escape: true,
          onRefCallback: _onRef,
          builder: (span, style) => Text.rich(span, style: style),
        ),
      ),
    );
  }

  Widget _buildEditor() {
    return TextField(
      controller: _controller,
      expands: true,
      maxLines: null,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(12.0),
        hintText: 'Enter some text...',
      ),
      style: _textStyle,
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
}
