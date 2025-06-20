import 'package:collection/collection.dart';
import 'package:flatypus/common/methods/loading_methods.dart';
import 'package:flatypus/common/snackbar.dart';
import 'package:flatypus/common/widgets/text_input_field_custom.dart';
import 'package:flatypus/state/controllers/loading_controller.dart';
import 'package:flatypus/state/providers/task_details_provider.dart';
import 'package:flatypus/state/providers/tasks_provider.dart';
import 'package:flatypus/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UnorderedListInputScreen extends ConsumerStatefulWidget {
  const UnorderedListInputScreen(
      {super.key, required this.taskId, required this.activities});
  final String taskId;
  final List<String> activities;

  @override
  ConsumerState<UnorderedListInputScreen> createState() =>
      _UnorderedListInputScreenState();
}

class _UnorderedListInputScreenState
    extends ConsumerState<UnorderedListInputScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _items = [];

  Future<void> _addItem() async {
    if (_controller.text.trim().isNotEmpty) {
      Loader.startLoading(context, ref);
      List<String> updatedItems = [..._items, _controller.text.trim()];
      final result = await ref
          .read(tasksProvider.notifier)
          .updateTaskActivities(
              taskId: widget.taskId, activities: updatedItems);

      if (result) {
        final task = ref.read(taskDetailsProvider);
        ref.read(taskDetailsProvider.notifier).updateTaskDetails(task!.copyWith(activities: updatedItems));
        setState(() {
          _items = updatedItems;
        });
        _controller.clear(); // Clear the input field after adding
      } else {
        showErrorSnackbar(label: 'Failed to add new activity!');
      }
      Loader.stopLoading(context, ref);
    }
  }

  Future<void> _removeItem(int index) async {
    Loader.startLoading(context, ref);
    List<String> updatedItems = [..._items];
    updatedItems.removeAt(index);
    final result = await ref
        .read(tasksProvider.notifier)
        .updateTaskActivities(taskId: widget.taskId, activities: updatedItems);
    if (result) {
      final task = ref.read(taskDetailsProvider);
      ref.read(taskDetailsProvider.notifier).updateTaskDetails(task!.copyWith(activities: updatedItems));
      setState(() {
        _items = updatedItems;
      });
    } else {
      showErrorSnackbar(label: 'Failed to remove the activity!');
    }

    Loader.stopLoading(context, ref);
  }

  @override
  void initState() {
    super.initState();
    _items = widget.activities;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        // Input Field
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: CustomTextInputField(
            hintText: 'Enter a name for the task',
            controller: _controller,
            borderType: UnderlineInputBorder,
            horzPadding: true,
            onFieldSubmitted: _addItem,
            suffixOnTap: _addItem,
            maxLength: 100,
            suffixIcon: FontAwesomeIcons.check,
          ),
        ),
        Wrap(
          children: _items
              .mapIndexed((index, item) => Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: ListTile(
                      title: Text(_items[index],
                          style:
                              TextStyle(color: AppColors.white.withAlpha(230))),
                      visualDensity: VisualDensity.compact,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      tileColor: AppColors.primaryColor.withAlpha(80),
                      leading: FaIcon(FontAwesomeIcons.solidCircle,
                          size: 8, color: AppColors.white.withAlpha(200)),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline,
                            size: 18, color: AppColors.yellowAccent),
                        onPressed: () => _removeItem(index),
                      ),
                      contentPadding: const EdgeInsets.only(left: 16, right: 6),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
