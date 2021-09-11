import 'package:flutter/material.dart';
import 'package:morningmagic/services/billing.dart';

enum MenuState { NIGT, MORNING }

MenuState menuState = MenuState.MORNING;

// Платежи и подписки
final BillingService billingService = BillingService();
State settingsPageState;
