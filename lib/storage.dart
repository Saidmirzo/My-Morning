import 'package:flutter/material.dart';
import 'package:morningmagic/services/billing.dart';

enum MenuState { NIGT, MORNING }

MenuState menuState = MenuState.MORNING;
// номер выделенного трека медитации в ночном режиме
int selIndexNightYoga = 0;

// Платежи и подписки
final BillingService billingService = BillingService();
State settingsPageState;
