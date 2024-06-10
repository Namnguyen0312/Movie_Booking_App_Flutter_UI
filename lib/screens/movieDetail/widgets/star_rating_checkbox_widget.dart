import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

class StarRatingCheckbox extends StatefulWidget {
  const StarRatingCheckbox({super.key});

  @override
  State<StarRatingCheckbox> createState() => _StarRatingCheckboxState();
}

class _StarRatingCheckboxState extends State<StarRatingCheckbox> {
  late int selectedStar;
  final TextEditingController _commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    selectedStar = 0;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        padding: const EdgeInsets.only(
            left: kDefaultPadding, right: kDefaultPadding, top: kTopPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: kTopPadding),
                  child: Center(
                    child: Text(
                      'Thêm bình luận',
                      style: GoogleFonts.beVietnamPro(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      if (selectedStar >= 1 &&
                          _commentController.text.isNotEmpty) {
                        String comment = _commentController.text;
                        Navigator.of(context)
                            .pop({'stars': selectedStar, 'comment': comment});
                      }
                    },
                    child: Text(
                      'Gửi',
                      style: GoogleFonts.beVietnamPro(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 2),
            TextField(
              controller: _commentController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Nhập bình luận của bạn...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 2,
              style: GoogleFonts.beVietnamPro(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 2),
            for (int i = 0; i < 5; i++)
              CheckboxListTile(
                title: Text('${i + 1} sao'),
                value: selectedStar == i + 1,
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedStar = i + 1;
                    }
                  });
                },
              ),
            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}
