import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCard extends StatelessWidget {
  final String divisi;
  final int progress;
  //// Pointer to Update Function
  final Function onUpdate;
  //// Pointer to Delete Function
  final Function onDelete;

  ItemCard(this.divisi, this.progress, {this.onUpdate, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.blueAccent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  divisi,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
              Text(
                "Progres Program $progress%",
                style: GoogleFonts.poppins(color: Colors.white70),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 60,
                child: RaisedButton(
                    shape: CircleBorder(),
                    color: Colors.blue[900],
                    child: Center(
                        child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      if (onUpdate != null) onUpdate();
                    }),
              ),
              SizedBox(
                height: 40,
                width: 60,
                child: RaisedButton(
                    shape: CircleBorder(),
                    color: Colors.red[900],
                    child: Center(
                        child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      if (onDelete != null) onDelete();
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
