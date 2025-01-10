import 'package:flutter/material.dart';

class GroupedTaskItem extends StatelessWidget {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> users;
  final void Function()? onTap;
  const GroupedTaskItem({
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
          height: 120,
          width: 350,
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
                              ));
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
                  const Text('12-12-2012'),
                  Image.asset('assets/icon/arrow.png'),
                  const Icon(
                    Icons.date_range_outlined,
                    color: Colors.lightBlue,
                  ),
                  const Text(
                    '12-12-2012',
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
