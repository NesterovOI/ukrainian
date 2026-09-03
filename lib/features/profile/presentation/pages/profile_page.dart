import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ukrainian/core/services/image_picker_service.dart';
import 'package:ukrainian/core/theme/theme.dart';
import 'package:ukrainian/core/widgets/custom_text_from_field.dart';
import 'package:ukrainian/features/home_lessons/presentation/provider/export_provider.dart';
import 'package:ukrainian/features/profile/presentation/providers/profile_controller.dart';
import 'package:ukrainian/features/profile/presentation/providers/theme_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusM),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(AppStrings.fromGallery),
                onTap: () async {
                  Navigator.pop(context);
                  final path = await ImagePickerService().pickAndSaveImage(
                    ImageSource.gallery,
                  );
                  if (path != null) {
                    ref
                        .read(userProgressNotifierProvider.notifier)
                        .updateAvatar(path);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(AppStrings.fromCamera),
                onTap: () async {
                  Navigator.pop(context);
                  final path = await ImagePickerService().pickAndSaveImage(
                    ImageSource.camera,
                  );
                  if (path != null) {
                    ref
                        .read(userProgressNotifierProvider.notifier)
                        .updateAvatar(path);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditNameDialog(BuildContext context, String currentName) {
    showDialog(
      context: context,
      builder: (context) => _EditNameDialog(initialName: currentName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProgressAsync = ref.watch(userProgressNotifierProvider);
    final profileState = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.navProfile), centerTitle: true),
      body: userProgressAsync.when(
        data: (progress) {
          final isPremium = progress.isPremium;

          return SingleChildScrollView(
            padding: EdgeInsets.all(AppDimensions.spaceM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Аватарка та Ім'я
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.primary,
                            backgroundImage: progress.avatarPath != null
                                ? FileImage(File(progress.avatarPath!))
                                : null,
                            child: progress.avatarPath == null
                                ? Icon(
                                    Icons.person,
                                    size: AppDimensions.iconSizeXL,
                                    color: AppColors.lightTextPrimary,
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () => _showImageSourceDialog(context),
                              child: CircleAvatar(
                                radius: AppDimensions.radiusM,
                                backgroundColor: AppColors.lightTextSecondary,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: AppDimensions.radiusM,
                                  color: AppColors.lightBackground,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.spaceS),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            progress.userName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: AppDimensions.iconSizeXM,
                            ),
                            onPressed: () =>
                                _showEditNameDialog(context, progress.userName),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceL),

                // 2. Блок підписки PRO
                Card(
                  color: isPremium
                      ? AppColors.primaryShadow.withAlpha(50)
                      : Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    side: BorderSide(
                      color: isPremium
                          ? AppColors.primaryShadow
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.spaceM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.workspace_premium,
                              color: isPremium
                                  ? AppColors.primary
                                  : AppColors.lightTextSecondary,
                              size: AppDimensions.iconSizeL,
                            ),
                            const SizedBox(width: AppDimensions.spaceS),
                            Text(
                              isPremium
                                  ? AppStrings.premiumUser
                                  : AppStrings.freeUser,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppDimensions.spaceS),
                        Text(
                          isPremium
                              ? AppStrings.premiumBenefits
                              : AppStrings.notPremiumBenefits,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        if (!isPremium) ...[
                          const SizedBox(height: AppDimensions.spaceM),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: profileState.isLoading
                                  ? null
                                  : () async {
                                      final success = await ref
                                          .read(
                                            profileControllerProvider.notifier,
                                          )
                                          .buyPremium();
                                      if (context.mounted && success) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(AppStrings.premiumOK),
                                          ),
                                        );
                                      }
                                    },
                              child: profileState.isLoading
                                  ? const CircularProgressIndicator()
                                  : Text(AppStrings.bayPremium),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceL),

                // 3. Блок налаштувань
                Text(
                  AppStrings.settings,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppDimensions.spaceS),

                //Налаштування теми
                ListTile(
                  leading: const Icon(Icons.palette_outlined),
                  title: Text(AppStrings.themeSettings),
                  trailing: DropdownButton<ThemeMode>(
                    value: ThemeMode.system,
                    onChanged: (mode) {
                      ref.read(themeProvider.notifier).setTheme(mode);
                    },
                    items: [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text(AppStrings.themeSystem),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text(AppStrings.themeLight),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(AppStrings.themeDark),
                      ),
                    ],
                  ),
                ),

                //Нагадування про навчання push
                SwitchListTile(
                  title: Text(AppStrings.rememberForStudy),
                  value: true,
                  onChanged: (enabled) {},
                ),

                //Відновлення покупки
                ListTile(
                  leading: const Icon(Icons.restore),
                  title: Text(AppStrings.resumePremium),
                  onTap: () async {
                    await ref
                        .read(profileControllerProvider.notifier)
                        .restorePurchases();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppStrings.verificationCompleted),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(AppStrings.errorAnalyticsPage + error.toString()),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

// Окремий StatefulWidget для діалогу з правильним dispose()
class _EditNameDialog extends ConsumerStatefulWidget {
  final String initialName;

  const _EditNameDialog({required this.initialName});

  @override
  ConsumerState<_EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends ConsumerState<_EditNameDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.editName),
      content: CustomTextFromField(
        controller: _controller,
        hintText: AppStrings.editName,
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => _controller.clear(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppStrings.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            final newName = _controller.text.trim();
            if (newName.isNotEmpty) {
              ref
                  .read(userProgressNotifierProvider.notifier)
                  .updateUserName(newName);
              Navigator.pop(context);
            }
          },
          child: Text(AppStrings.save),
        ),
      ],
    );
  }
}
