import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/fti_untar.png', width: 180),
                    SizedBox(width: 20),
                    Image.asset('assets/logo_si.png', width: 185),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Text('Eric Ang', style: GoogleFonts.openSans(fontSize: 30, color: Colors.blueGrey),),
              Text('825210098', style: GoogleFonts.roboto(fontSize: 25, color: Colors.blueGrey),),
              SizedBox(height: 95),
              Text('Dosen Pembimbing :', style: GoogleFonts.openSans(fontSize: 20, color: Colors.blueGrey),),
              SizedBox(height: 5),
              Text('NOVARIO JAYA PERDANA S.Kom., M.T.', style: GoogleFonts.roboto(fontSize: 20, color: Colors.blueGrey),),
            ],
          ),
        ),
      ),
    );
  }
}

