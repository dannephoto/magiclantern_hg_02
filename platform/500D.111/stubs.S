/** \file
 * Entry points into the firmware image.
 *
 * These are the functions that we can call from our tasks
 * in the Canon 1.1.1 firmware for the 500d.
 *
 *
 *	-- All stubs marked with //d are verified and correct --
 *	--- Coutts
 *
 *
 *
 * Copyright (C) 2010 Magic Lantern Team
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the
 * Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor,
 * Boston, MA  02110-1301, USA.
 */

#include <stub.h>

.text

// for task information


/** Startup **/
NSTUB( ROMBASEADDR, firmware_entry )
NSTUB(0xFF010894,  cstart)
NSTUB(0xFF3EBCB8,  bzero32)                                 // called by cstart()
NSTUB(0xFF0174E0,  create_init_task)
NSTUB(0xFF011DBC,  init_task)                               // passed as arg to create_init_task, look for dmSetup
NSTUB(   0x150FC,  additional_version)                      /** Find the additional version string in GUI_GetFirmVersion */

/** File I/O **/
NSTUB(0xFF196494,  FIO_CloseFile)
NSTUB(0xFF1975A4,  FIO_FindClose)                           // called with ret_FIO_FindFirstEx after finishing the dir scanning loop
NSTUB(0xFF1974A4,  FIO_FindNextEx)
NSTUB(0xFF196724, _FIO_ReadFile)
NSTUB(0xFF1967D4,  FIO_SeekSkipFile)
NSTUB(0xFF1968D4, _FIO_WriteFile)
NSTUB(0xFF196CF8, _FIO_CreateDirectory)
NSTUB(0xFF1963EC, _FIO_CreateFile)
NSTUB(0xFF197378, _FIO_FindFirstEx)
NSTUB(0xFF196A88, _FIO_GetFileSize)
NSTUB(0xFF196338, _FIO_OpenFile)
NSTUB(0xFF196608, _FIO_RemoveFile)
// NSTUB(    ???, _FIO_RenameFile)                          /* present on 60D.111, 6D.113, 600D.102, 650D.104, 550D.109, 1100D.105, EOSM.202, 700D.113 */

/** GUI **/
NSTUB(    0x1C70,  gui_main_struct)                         // in gui_main_task
NSTUB(   0x1874C,  gui_task_list)                           // look in gui_task_create
NSTUB(0xFF023164,  GUI_ChangeMode)
NSTUB(0xFF022F64,  GUI_Control)
NSTUB(0xFF1BECF4,  GUI_SetLvMode)
NSTUB(0xFF08EB90,  SetGUIRequestMode)
NSTUB(0xFF023450,  gui_init_end)                            // EndGuiInit
NSTUB(0xFF022A9C,  gui_main_task)                           // identical to 5d2 and 500d
NSTUB(0xFF08F638,  gui_massive_event_loop)                  // GUI_Control_Post
// NSTUB(    ???,  GUI_SetMovieSize_a)                      /* present on 50D.109 */
// NSTUB(    ???,  GUI_SetMovieSize_b)                      /* present on 50D.109 */
// NSTUB(    ???,  Gui_SetSoundRecord)                      /* present on 6D.113, 5D2.212 */

/** ASIF **/
NSTUB(0xFF056D70,  PowerAudioOutput)
NSTUB(0xFF056810,  SetAudioVolumeOut)
NSTUB(0xFF053D7C,  SetNextASIFADCBuffer)
NSTUB(0xFF053E34,  SetNextASIFDACBuffer)
NSTUB(0xFF056584,  SetSamplingRate)
NSTUB(0xFF053614,  StartASIFDMAADC)
NSTUB(0xFF0537B0,  StartASIFDMADAC)
NSTUB(0xFF053880,  StopASIFDMADAC)
// NSTUB(    ???,  PowerMicAmp)                             /* present on 650D.104, EOSM.202, 700D.113 */
// NSTUB(    ???,  SetASIFMode)                             /* present on 700D.113 */
// NSTUB(    ???,  SetAudioVolumeIn)                        /* present on 6D.113 */
// NSTUB(    ???,  SoundDevActiveIn)                        /* present on 7D.203, 6D.113, 650D.104, EOSM.202, 700D.113 */
// NSTUB(    ???,  SoundDevShutDownIn)                      /* present on 7D.203, 6D.113, 650D.104, EOSM.202, 700D.113 */
// NSTUB(    ???,  StopASIFDMAADC)                          /* present on 7D.203, 6D.113, EOSM.202 */

/** Audio **/
NSTUB(    0x1F04,  sounddev)                                // in sounddev_task
NSTUB(0xFF056EB0, _audio_ic_read)
NSTUB(0xFF056064, _audio_ic_write)
NSTUB(0xFF054B8C,  sounddev_active_in)
NSTUB(0xFF0549E8,  sounddev_task)
//NSTUB( 0xFF48E58C, audio_thresholds ) // not present in 500D - see audio.c (thank you alex).
// NSTUB(    ???, _audio_ic_write_bulk)                     /* present on 6D.116 */

/** Bitmap **/
NSTUB(   0x27E40,  LCD_Palette)                             // in InitializeBitmapDisplayDevice, right after 0xc0f14800
NSTUB(   0x27E04,  bmp_vram_info)

/** CFN **/
NSTUB(0xFF359804,  GetCFnData)
NSTUB(0xFF359A0C,  SetCFnData)
// NSTUB(    ???,  GUI_GetCFnForTab4)                       /* present on 7D.203 */
// NSTUB(    ???,  GUI_SetCFnForTab4)                       /* present on 7D.203 */

/** Camera interface? **/
NSTUB(0xC0220000,  camera_engine)                           /** Camera interface? */

/** DMA **/
// NSTUB(    ???,  dma_memcpy)                              /* present on 7D.203, 6D.113, 50D.109, 600D.102, 650D.104, 1100D.105, EOSM.202, 700D.113 */

/** Debug messages **/
NSTUB(    0x2D18,  dm_names)                                // in DebugMsg, before the 1st loop target
NSTUB(0xFF066A98,  DryosDebugMsg)                           /** Look for the normal printf strings */
NSTUB(0xFF066DE4,  dm_set_store_level)                      // called by "dmstore"

/** Dialog API **/
NSTUB(0xFF269270,  dialog_redraw)
NSTUB(0xFF2C9128,  dialog_set_property_str)

/** Dialog handlers **/
NSTUB(0xFF371068,  ErrCardForLVApp_handler)
NSTUB(0xFF2A0D94,  ErrForCamera_handler)                    // ERR70, ERR80 etc (DlgErrForCamera.c, AJ_DIALOG.HANDLER_DlgErrForCamera.c)
NSTUB(0xFF2AE79C,  LiveViewApp_handler)
NSTUB(0xFF2BE2F4,  PlayMain_handler)
NSTUB(0xFF36F6E8,  PlayMovieGuideApp_handler)
NSTUB(0xFF2C5D1C,  ShootOlcApp_handler)
// NSTUB(    ???,  HideUnaviFeedBack_maybe)                 /* present on 60D.111, 6D.113, 5D3.113, 600D.102, 650D.104, 550D.109, 1100D.105, EOSM.202, 700D.113 */
// NSTUB(    ???,  LiveViewApp_handler_BL_JudgeBottomInfoDispTimerState)/* present on 60D.111, 6D.113, 600D.102, 650D.104, 550D.109, 1100D.105, 700D.113 */
// NSTUB(    ???,  LiveViewApp_handler_end)                 /* present on 60D.111, 600D.102, 650D.104, 550D.109, 1100D.105, 700D.113 */
// NSTUB(    ???,  LiveViewLevelApp_handler)                /* present on 5D3.113 */
// NSTUB(    ???,  LiveViewShutterApp_handler)              /* present on 6D.113, 650D.104, EOSM.202, 700D.113 */
// NSTUB(    ???,  LiveViewWbApp_handler)                   /* present on 7D.203, 5D3.113, 5D2.212 */
// NSTUB(    ???,  LiveViewWifiApp_handler)                 /* present on 6D.113 */
// NSTUB(    ???,  StartPlayProtectGuideApp)                /* present on 7D.203, 5D2.212 */
// NSTUB(    ???,  StopPlayProtectGuideApp)                 /* present on 7D.203, 5D2.212 */

/** Display **/
// NSTUB(    ???,  MirrorDisplay)                           /* present on 60D.111, 600D.102, 650D.104, 550D.109, 1100D.105, 700D.113 */
// NSTUB(    ???,  NormalDisplay)                           /* present on 60D.111, 600D.102, 650D.104, 550D.109, 1100D.105, 700D.113 */
// NSTUB(    ???,  ReverseDisplay)                          /* present on 60D.111, 600D.102, 650D.104, 550D.109, 1100D.105, 700D.113 */

/** EDMAC **/
NSTUB(0xFF18FCC0,  AbortEDmac)
NSTUB(0xFF18FB90,  ConnectReadEDmac)
NSTUB(0xFF18FB68,  ConnectWriteEDmac)
NSTUB(0xFF18FD88,  RegisterEDmacAbortCBR)
NSTUB(0xFF18FD60,  RegisterEDmacCompleteCBR)
NSTUB(0xFF18FE60,  RegisterEDmacPopCBR)
NSTUB(0xFF18FB4C,  SetEDmac)
NSTUB(0xFF18FBF0,  StartEDmac)
NSTUB(0xFF18FE30,  UnregisterEDmacAbortCBR)
NSTUB(0xFF18FD74,  UnregisterEDmacCompleteCBR)
NSTUB(0xFF18FE74,  UnregisterEDmacPopCBR)
///NSTUB([idk], AbortEDmac)

/** Electronic Level **/
// NSTUB(    ???,  GUI_SetRollingPitchingLevelStatus)       /* present on 7D.203, 60D.111, 6D.113, 5D3.113, 600D.102, 650D.104, 550D.109, 700D.113 */

/** Engio **/
NSTUB(0xFF190B84, _EngDrvOut)
NSTUB(0xFF190CF4, _engio_write)
NSTUB(0xFF190BE8,  shamem_read)
// NSTUB(    ???,  EngDrvOut)                               /* present on 7D_MASTER.203 */

/** Eventprocs (call by name) **/
NSTUB(0xFF067828,  call)

/** Events **/
// NSTUB(    ???,  TryPostEvent)                            /* present on 6D.113, 650D.104, EOSM.202, 700D.113 */
// NSTUB(    ???,  TryPostEvent_end)                        /* present on 6D.113, 650D.104, EOSM.202, 700D.113 */
// NSTUB(    ???,  TryPostStageEvent)                       /* present on 6D.113, 650D.104, EOSM.202, 700D.113 */
// NSTUB(    ???,  TryPostStageEvent_end)                   /* present on 6D.113, 650D.104, EOSM.202, 700D.113 */

/** ExMem **/
NSTUB(0xFF06C3A8,  AddMemoryChunk)
NSTUB(0xFF06EECC,  AllocateContinuousMemoryResource)        // m_pfContAllocMemoryCBR
NSTUB(0xFF06EE88,  AllocateMemoryResource)                  // m_pfAllocMemoryCBR
NSTUB(0xFF06B90C,  CreateMemoryChunk)
NSTUB(0xFF06C0D0,  CreateMemorySuite)
NSTUB(0xFF06BEEC,  DeleteMemorySuite)
NSTUB(0xFF06EFDC,  FreeMemoryResource)                      // m_pfFreeMemoryCBR
NSTUB(0xFF06C494,  GetFirstChunkFromSuite)                  // AJ_PackMemory_PackMem_p3
NSTUB(0xFF06BE78,  GetMemoryAddressOfMemoryChunk)           // AJ_PackMemory_PackMem.c_IsChunkSignature
NSTUB(0xFF06CC4C,  GetNextMemoryChunk)                      // AJ_PackMemory_PackMem.c_IsChunkSignature_p2
NSTUB(0xFF02A788,  SRM_AllocateMemoryResourceFor1stJob)
NSTUB(0xFF02C6F8,  SRM_FreeMemoryResourceFor1stJob)

/** GUI for old cameras **/
NSTUB(    0x3B90,  gui_timer_struct)                        // in GUI_Control_Post
NSTUB(0xFF09186C,  gui_change_lcd_state_post)
NSTUB(0xFF090C4C,  gui_change_mode)                         // GUI_ChangeMode_Post
NSTUB(0xFF0917D4,  gui_change_shoot_type_post)
NSTUB(0xFF091E9C,  gui_init_event)
NSTUB(0xFF091114,  gui_local_post)
NSTUB(0xFF0915F0,  gui_other_post)
NSTUB(0xFF091720,  gui_post_10000085)                       // should be called post 100000a5 no ? <-- not sure what this means..
NSTUB(0xFF1A09AC,  gui_timer_something)

/** GUI timers **/
NSTUB(0xFF2B80AC,  CancelDateTimer)
NSTUB(0xFF070700,  CancelTimer)
NSTUB(0xFF068268,  SetHPTimerAfterNow)
NSTUB(0xFF0682E8,  SetHPTimerNextTick)
NSTUB(0xFF070500,  SetTimerAfter)

/** H264 Encoder **/
NSTUB(    0x8684,  mvr_config)
NSTUB(0xFF17C2AC,  mvrFixQScale)
NSTUB(0xFF17BE38,  mvrSetDefQScale)
NSTUB(0xFF17BE70,  mvrSetFullHDOptSize)
// NSTUB(    ???,  mvrSetGopOptSizeFULLHD)                  /* present on 600D.102, 550D.109, 1100D.105 */

/** Interrupts **/
// NSTUB(    ???,  isr_table_handler)                       /* present on 7D_MASTER.203 */
// NSTUB(    ???,  isr_table_param)                         /* present on 7D_MASTER.203 */
// NSTUB(    ???,  post_isr_hook)                           /* present on 7D.203, 6D.113, 5D3.113, EOSM.202 */
// NSTUB(    ???,  pre_isr_hook)                            /* present on 7D.203, 6D.113, 5D3.113, 7D_MASTER.203, EOSM.202 */

/** LCD Sensor **/
NSTUB(0xFF079B68,  DispSensorStart)
// NSTUB(    ???,  LightMeasure_n_Callback_r0)              /* present on 7D.203, 5D2.212 */

/** Making the card bootable **/
NSTUB(   0x235E0,  cf_device)                               // in cfReadBlk
NSTUB(   0x23624,  sd_device)                               // in sdReadBlk
NSTUB(0xFF330304,  fsuDecodePartitionTable)
// NSTUB(    ???,  cf_device_ptr)                           /* present on 5D3.113 */

/** Memory allocation **/
NSTUB(0xFF06AA58,  GetMemoryInformation)                    // called from AllocateMemory
NSTUB(0xFF06AA04,  GetSizeOfMaxRegion)
NSTUB(0xFF06ACB4, _AllocateMemory)                          // thanks Alex
NSTUB(0xFF06B044, _FreeMemory)                              // release_mem in Indy's IDC
NSTUB(0xFF1A7298, _alloc_dma_memory)
NSTUB(0xFF019044, _free)
NSTUB(0xFF1A72CC, _free_dma_memory)
NSTUB(0xFF018F70, _malloc)                                  // maybe it's better to use Allocate/Free?
// NSTUB(    ???,  free_dma_memory)                         /* present on 7D_MASTER.203 */

/** Message queues **/
NSTUB(0xFF0696FC,  msg_queue_count)                         /* present on 7D.203, 60D.111, 6D.113, 5D3.113, 50D.109, 5D2.212, 600D.102, 650D.104, 550D.109, 1100D.105, EOSM.202, 700D.113 */
NSTUB(0xFF0693C0,  msg_queue_create)
NSTUB(0xFF0696BC,  msg_queue_post)
NSTUB(0xFF0694D0,  msg_queue_receive)

/** PTP **/
NSTUB(0xFF20C498,  ptp_register_handler)
// NSTUB(    ???,  ptpPropSetUILock)                        /* present on 650D.104, 700D.113 */

/** Properties **/
NSTUB(0xFF05993C, _prop_cleanup)
NSTUB(0xFF059988, _prop_request_change)
NSTUB(0xFF0597E0,  prop_deliver)
NSTUB(0xFF059868,  prop_register_slave)                     // called by"GUI_RegisterPropertySlave"
// NSTUB(    ???,  prop_unregister_slave)                   /* present on 7D.203 */

/** RPC (for 7D) **/
// NSTUB(    ???,  BulkInIPCTransfer)                       /* present on 7D.203 */
// NSTUB(    ???,  BulkOutIPCTransfer)                      /* present on 7D.203 */
// NSTUB(    ???,  QuickOutIPCTransfer)                     /* present on 7D.203 */
// NSTUB(    ???,  RegisterRPCHandler)                      /* present on 7D.203, 7D_MASTER.203 */
// NSTUB(    ???,  RequestRPC)                              /* present on 7D.203, 7D_MASTER.203 */

/** Recursive locks **/
NSTUB(0xFF1A0D44,  AcquireRecursiveLock)
NSTUB(0xFF06DEC0,  CreateRecursiveLock)
NSTUB(0xFF1A0E58,  ReleaseRecursiveLock)                    // not sure, these are not called anywhere

/** ResLock **/
NSTUB(0xFF19384C,  CreateResLockEntry)                      /* present on 7D.203, 60D.111, 6D.113, 5D3.113, 50D.109, 650D.104, 1100D.105, EOSM.202, 700D.113 */
NSTUB(0xFF194190,  LockEngineResources)                     /* present on 7D.203, 60D.111, 6D.113, 5D3.113, 50D.109, 650D.104, 1100D.105, EOSM.202, 700D.113 */
NSTUB(0xFF193ED0,  UnLockEngineResources)                   /* present on 7D.203, 60D.111, 6D.113, 5D3.113, 50D.109, 650D.104, 1100D.105, EOSM.202, 700D.113 */

/** Semaphores **/
NSTUB(0xFF069770,  create_named_semaphore)
NSTUB(0xFF0699B8,  give_semaphore)
NSTUB(0xFF0698D0,  take_semaphore)

/** Task info **/
NSTUB(    0x31DC,  task_max)
NSTUB(0xFF018338,  is_taskid_valid)                         // AJ_task_trampoline_related_p10
NSTUB(    0x1A74,  current_task)
NSTUB(     0x668,  current_interrupt)                       // in interrupt handler (0x18), where MEM(C0201004) is stored

/** Task sleep **/
NSTUB(0xFF069D74,  msleep)                                  // called from EV_GETDONE_CACHE param 0x64

/** Tasks **/
NSTUB(    0x1934,  task_dispatch_hook)                      /** Task dispatch hook hasn't moved in several versions */
NSTUB(0xFF069E2C,  task_create)
NSTUB(0xFF072B30,  task_trampoline)
// NSTUB(    ???,  current_task_ctx)                        /* present on 7D.203 */
// NSTUB(    ???,  next_task_ctx)                           /* present on 7D.203 */

/** Misc **/
NSTUB(0xFF0642D0,  LoadCalendarFromRTC)
NSTUB(0xFF1A442C,  vsnprintf)                               /** Look in DebugMsg, near the bottom.  It calls vsnprintf() -- with a buffer size of 0x4C. */
NSTUB(    0x49B4,  pfAfComplete_counter)
NSTUB(0xFF2AB500,  FirstWarningTimer_CBR)                   /* to stop the "Press * to AF" message in LiveView */
// NSTUB(    ???,  EnableImagePhysicalScreenParameter)      /* present on 7D.203, 50D.109, 5D2.212 */
// NSTUB(    ???,  FSUunMountDevice)                        /* present on 5D3.113 */
// NSTUB(    ???,  PtpDps_remote_release_SW1_SW2_worker)    /* present on 7D.203, 5D2.212 */
// NSTUB(    ???,  lv_path_struct)                          /* present on 60D.111, 600D.102, 550D.109, 1100D.105 */
// NSTUB(    ???,  memcpy)                                  /* present on 7D_MASTER.203 */

/** Unused stubs or porting notes **/
///NSTUB(0xFF2C92BC,  ChangeColorPalette)
///NSTUB(0xFF26896C,  CreateDialogBox)
///NSTUB(0xFF2683F4,  DeleteDialogBox)
///NSTUB(0xFF1968A4,  FIO_SeekFile)
///NSTUB(0xFF1C6630,  GUI_GetFirmVersion)
///NSTUB(0xFF062800,  GetDisplayType)
///NSTUB(0xFF1C864C,  GuiEdLedBlink)
///NSTUB(0xFF1C8628,  GuiEdLedOff)
///NSTUB(0xFF1C8604,  GuiEdLedOn)
///NSTUB(   0x3787C,  LV_EX_X)                                 // couldn't find in 500d dump anywhere -- for hdmi related stuff
///NSTUB(   0x37880,  LV_EX_Y)                                 // couldn't find in 500d dump anywhere -- for hdmi related stuff
///NSTUB(0xFF05ED84,  MuteOff_0)                               // not quite the same as in other cameras, but should work
///NSTUB(0xFF05ED40,  MuteOn_0)                                // idem
///NSTUB(0xFF05A57C,  PROPAD_GetPropertyData)
///NSTUB(0xFF18FD74,  PopEDmac)
///NSTUB(0xFF2822A4,  RedrawDisplay)
///NSTUB(0xFF05FF18,  SetBitmapVramAddress)                    // where to find bmp_vram_info
///NSTUB(0xFF2B0384,  SetOutputTypeByPressInfoToStorage)
///NSTUB(0xFF059AA4, _prop_get_value)
///NSTUB(0xFF06670C,  bootdisk_disable)
///NSTUB(0xFF066700,  bootdisk_enable)
///NSTUB(0xFF386868,  cfReadBlk)
///NSTUB(0xFF012E44,  cli_save)
///NSTUB(0xFF267624,  ctrlman_dispatch_event)
///NSTUB(0xFF198F74,  dispcheck)
///NSTUB(0xFF066D7C,  dm_set_print_level)
///NSTUB(0xFF066A18,  dmstart)                                 /** Debugging commands are all registered by name.  Search for the strings */
///NSTUB(0xFF066A58,  dmstop)
///NSTUB(0xFF06732C,  dumpf)
///NSTUB(0xFF11E080,  gui_lock)                                // PtpPropSetUILock
///NSTUB(0xFF267774,  gui_task_create)
///NSTUB(0xFF267894,  gui_task_destroy)
///NSTUB(    0x1AF4,  hotplug_struct)
///NSTUB(0xFF01DCCC,  hotplug_task)
///NSTUB(    0x1B24,  hotplug_usb_buf)                         // after "USB Disconnect"
///NSTUB(    0x1C28,  main_ctrl_struct)
///NSTUB(   0x25670,  main_ctrl_struct_2)
///NSTUB(0xFF020828,  main_ctrl_task)
///NSTUB(0xFF04E724,  mvrSetBitRate)
///NSTUB(0xFF17BDC8,  mvrSetDeblockingFilter)
///NSTUB(0xFF17C2CC,  mvrSetPrintMovieLog)
///NSTUB(0xFF17BFF0,  mvrSetVGAOptSize)
///NSTUB(0xFF068268,  oneshot_timer)
///NSTUB(0xFF1BC46C,  prop_change__DispType)
///NSTUB(0xFF0932FC,  prop_request_icu_auto_poweroff)
///NSTUB(0xFF1A5BEC,  register_func)                           /** Find the shell register commands */
///NSTUB(0xFF392DC8,  sdReadBlk)
///NSTUB(0xFF012E58,  sei_restore)
///NSTUB(0xFF2ABC74,  set_lv_stuff_to_win_system__maybe)
///NSTUB(0xFF23AC68,  vram_get_number)
///NSTUB(0xFF198194,  vram_get_pos_and_size)
///NSTUB(   0x37384,  vram_info)                               // located in vram_get_number
