import 'package:flutter/material.dart';

class ProjectCardItem extends StatelessWidget {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> users;
  final void Function()? onTap;
  const ProjectCardItem({
    super.key,
    this.onTap,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 140,
          width: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    width: 90,
                    height: 36,
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        if (index <= 2) {
                          return Align(
                            alignment: AlignmentDirectional.centerStart,
                            widthFactor: 0.55,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              maxRadius: 18,
                              child: Text(users[index].substring(0, 1)),
                            ),
                          );
                        } else if (index == 3) {
                          return Align(
                            alignment: AlignmentDirectional.centerStart,
                            widthFactor: 0.55,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              maxRadius: 18,
                              child: Text('+${users.length - index}'),
                            ),
                          );
                        } else {
                          return null;
                        }
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.date_range_outlined,
                    color: Colors.grey,
                  ),
                  const Text('startDate'),
                  Image.asset('assets/icon/arrow.png'),
                  const Icon(
                    Icons.date_range_outlined,
                    color: Colors.lightBlue,
                  ),
                  const Text(
                    'endDate',
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('50%'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.5,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: '24', style: TextStyle(color: Colors.grey)),
                        TextSpan(
                            text: '/48 tasks',
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
