PGDMP     '    -    	            |            viewleafresortdb    15.4    15.4 A    o           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            p           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            q           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            r           1262    82260    viewleafresortdb    DATABASE     �   CREATE DATABASE viewleafresortdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
     DROP DATABASE viewleafresortdb;
                postgres    false                        2615    82261    dbo    SCHEMA        CREATE SCHEMA dbo;
    DROP SCHEMA dbo;
                postgres    false            �            1255    82262    usp_reset() 	   PROCEDURE     �  CREATE PROCEDURE dbo.usp_reset()
    LANGUAGE plpgsql
    AS $_$
begin

	DELETE FROM dbo."Notifications";
	DELETE FROM dbo."RoomBooking";
	DELETE FROM dbo."Room";
	DELETE FROM dbo."RoomType";
	DELETE FROM dbo."GatewayConnectedUsers";
	DELETE FROM dbo."Notifications";
	DELETE FROM dbo."UserProfilePic";
	DELETE FROM dbo."Files";
	DELETE FROM dbo."Users";
	DELETE FROM dbo."Access";
	
	ALTER SEQUENCE dbo."Notifications_NotificationId_seq" RESTART WITH 1;
	ALTER SEQUENCE dbo."RoomBooking_RoomBookingId_seq" RESTART WITH 1;
	ALTER SEQUENCE dbo."Room_RoomId_seq" RESTART WITH 1;
	ALTER SEQUENCE dbo."RoomType_RoomTypeId_seq" RESTART WITH 1;
	ALTER SEQUENCE dbo."GatewayConnectedUsers_Id_seq" RESTART WITH 1;
	ALTER SEQUENCE dbo."Notifications_NotificationId_seq" RESTART WITH 1;
	ALTER SEQUENCE dbo."Users_UserId_seq" RESTART WITH 1;
	ALTER SEQUENCE dbo."Access_AccessId_seq" RESTART WITH 1;
	ALTER SEQUENCE dbo."Files_FileId_seq" RESTART WITH 1;
	
	
	INSERT INTO dbo."Access" (
		"AccessCode",
		"Name", 
		"Active",
		"AccessPages"
	)
	VALUES (
			'000001',
			'Admin',
			true,
			'[
      {
        "page": "Dashboard",
        "view": true,
        "modify": true,
        "rights": []
      },
      {
        "page": "Booking History",
        "view": true,
        "modify": true,
        "rights": ["Approval"]
      },
      {
        "page": "Room",
        "view": true,
        "modify": true,
        "rights": []
      },
      {
        "page": "Room Type",
        "view": true,
        "modify": true,
        "rights": []
      },
      {
        "page": "Users",
        "view": true,
        "modify": true,
        "rights": []
      },
      {
        "page": "User group",
        "view": true,
        "modify": true,
        "rights": []
      }
    ]');
	
	INSERT INTO dbo."Users" (
		"UserCode",
		"UserName",
		"Password", 
		"FullName",
		"Gender",
		"BirthDate",
		"Email",
		"ConfirmationCode",
		"ConfirmationComplete",
		"MobileNumber",
		"AccessGranted",
		"AccessId",
		"UserType")
	VALUES (
			'000001',
			'admin',
			'$2b$10$LqN3kzfgaYnP5PfDZFfT4edUFqh5Lu7amIxeDDDmu/KEqQFze.p8a',  
			'Admin Admin',
			'GENDER',
			'1998-07-18',
			'admin@admin.com',
			'0', 
			true,
			'123456',
			true,
			1,
			'STAFF');
	
END;
$_$;
     DROP PROCEDURE dbo.usp_reset();
       dbo          postgres    false    6            �            1259    82263    Access    TABLE     �   CREATE TABLE dbo."Access" (
    "AccessId" bigint NOT NULL,
    "Name" character varying NOT NULL,
    "AccessPages" json DEFAULT '[]'::json NOT NULL,
    "Active" boolean DEFAULT true NOT NULL,
    "AccessCode" character varying
);
    DROP TABLE dbo."Access";
       dbo         heap    postgres    false    6            �            1259    82270    Access_AccessId_seq    SEQUENCE     �   ALTER TABLE dbo."Access" ALTER COLUMN "AccessId" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dbo."Access_AccessId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            dbo          postgres    false    6    215            �            1259    82285    Files    TABLE     i   CREATE TABLE dbo."Files" (
    "FileId" bigint NOT NULL,
    "FileName" text NOT NULL,
    "Url" text
);
    DROP TABLE dbo."Files";
       dbo         heap    postgres    false    6            �            1259    82290    Files_FileId_seq    SEQUENCE     �   ALTER TABLE dbo."Files" ALTER COLUMN "FileId" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dbo."Files_FileId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            dbo          postgres    false    6    217            �            1259    82291    GatewayConnectedUsers    TABLE     �   CREATE TABLE dbo."GatewayConnectedUsers" (
    "Id" bigint NOT NULL,
    "SocketId" character varying(100) NOT NULL,
    "UserId" bigint NOT NULL
);
 (   DROP TABLE dbo."GatewayConnectedUsers";
       dbo         heap    postgres    false    6            �            1259    82294    GatewayConnectedUsers_Id_seq    SEQUENCE     �   ALTER TABLE dbo."GatewayConnectedUsers" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dbo."GatewayConnectedUsers_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            dbo          postgres    false    219    6            �            1259    82295    Notifications    TABLE     �  CREATE TABLE dbo."Notifications" (
    "NotificationId" bigint NOT NULL,
    "Title" character varying NOT NULL,
    "Description" character varying NOT NULL,
    "Type" character varying NOT NULL,
    "ReferenceId" character varying NOT NULL,
    "IsRead" boolean DEFAULT false NOT NULL,
    "UserId" bigint NOT NULL,
    "Date" timestamp with time zone DEFAULT (now() AT TIME ZONE 'Asia/Manila'::text) NOT NULL
);
     DROP TABLE dbo."Notifications";
       dbo         heap    postgres    false    6            �            1259    82302     Notifications_NotificationId_seq    SEQUENCE     �   ALTER TABLE dbo."Notifications" ALTER COLUMN "NotificationId" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dbo."Notifications_NotificationId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            dbo          postgres    false    6    221            �            1259    82539    Room    TABLE     C  CREATE TABLE dbo."Room" (
    "RoomId" bigint NOT NULL,
    "RoomNumber" character varying NOT NULL,
    "RoomTypeId" bigint NOT NULL,
    "AdultCapacity" bigint DEFAULT 0 NOT NULL,
    "ChildrenCapacity" bigint DEFAULT 0 NOT NULL,
    "RoomRate" numeric DEFAULT 0 NOT NULL,
    "DateAdded" timestamp with time zone DEFAULT (now() AT TIME ZONE 'Asia/Manila'::text) NOT NULL,
    "DateLastUpdated" timestamp with time zone,
    "Status" character varying DEFAULT 'AVAILABLE'::character varying NOT NULL,
    "Active" boolean DEFAULT true NOT NULL,
    "ThumbnailFileId" bigint
);
    DROP TABLE dbo."Room";
       dbo         heap    postgres    false    6            �            1259    82560    RoomBooking    TABLE     A  CREATE TABLE dbo."RoomBooking" (
    "RoomBookingId" bigint NOT NULL,
    "RoomBookingCode" character varying,
    "BookedByUserId" bigint NOT NULL,
    "RoomId" bigint NOT NULL,
    "DateCreated" timestamp with time zone DEFAULT (now() AT TIME ZONE 'Asia/Manila'::text) NOT NULL,
    "DateLastUpdated" timestamp with time zone,
    "CheckInDate" timestamp with time zone DEFAULT (now() AT TIME ZONE 'Asia/Manila'::text) NOT NULL,
    "CheckOutDate" timestamp with time zone DEFAULT (now() AT TIME ZONE 'Asia/Manila'::text) NOT NULL,
    "RoomRateAmount" numeric DEFAULT 0 NOT NULL,
    "OtherCharges" numeric DEFAULT 0 NOT NULL,
    "TotalAmount" numeric DEFAULT 0 NOT NULL,
    "Status" character varying DEFAULT 'PENDING'::character varying NOT NULL,
    "Guest" character varying DEFAULT 'WALK-IN'::character varying NOT NULL
);
    DROP TABLE dbo."RoomBooking";
       dbo         heap    postgres    false    6            �            1259    82559    RoomBooking_RoomBookingId_seq    SEQUENCE     �   ALTER TABLE dbo."RoomBooking" ALTER COLUMN "RoomBookingId" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dbo."RoomBooking_RoomBookingId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            dbo          postgres    false    232    6            �            1259    82493    RoomType    TABLE     m  CREATE TABLE dbo."RoomType" (
    "RoomTypeId" bigint NOT NULL,
    "RoomTypeCode" character varying,
    "Name" character varying NOT NULL,
    "Active" boolean DEFAULT true NOT NULL,
    "DateAdded" timestamp with time zone DEFAULT (now() AT TIME ZONE 'Asia/Manila'::text) NOT NULL,
    "DateLastUpdated" timestamp with time zone,
    "ThumbnailFileId" bigint
);
    DROP TABLE dbo."RoomType";
       dbo         heap    postgres    false    6            �            1259    82492    RoomType_RoomTypeId_seq    SEQUENCE     �   ALTER TABLE dbo."RoomType" ALTER COLUMN "RoomTypeId" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dbo."RoomType_RoomTypeId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            dbo          postgres    false    6    228            �            1259    82538    Room_RoomId_seq    SEQUENCE     �   ALTER TABLE dbo."Room" ALTER COLUMN "RoomId" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dbo."Room_RoomId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            dbo          postgres    false    230    6            �            1259    82341    SystemConfig    TABLE     r   CREATE TABLE dbo."SystemConfig" (
    "Key" character varying NOT NULL,
    "Value" character varying NOT NULL
);
    DROP TABLE dbo."SystemConfig";
       dbo         heap    postgres    false    6            �            1259    82368    UserProfilePic    TABLE     b   CREATE TABLE dbo."UserProfilePic" (
    "UserId" bigint NOT NULL,
    "FileId" bigint NOT NULL
);
 !   DROP TABLE dbo."UserProfilePic";
       dbo         heap    postgres    false    6            �            1259    82371    Users    TABLE       CREATE TABLE dbo."Users" (
    "UserId" bigint NOT NULL,
    "UserName" character varying NOT NULL,
    "Password" character varying NOT NULL,
    "FullName" character varying NOT NULL,
    "Gender" character varying DEFAULT 'Others'::character varying NOT NULL,
    "BirthDate" date NOT NULL,
    "MobileNumber" character varying NOT NULL,
    "AccessGranted" boolean NOT NULL,
    "AccessId" bigint,
    "Active" boolean DEFAULT true NOT NULL,
    "UserCode" character varying,
    "Address" character varying DEFAULT 'NA'::character varying NOT NULL,
    "UserType" character varying NOT NULL,
    "Email" character varying DEFAULT ''::character varying NOT NULL,
    "ConfirmationCode" character varying DEFAULT 0 NOT NULL,
    "ConfirmationComplete" boolean DEFAULT false NOT NULL
);
    DROP TABLE dbo."Users";
       dbo         heap    postgres    false    6            �            1259    82379    Users_UserId_seq    SEQUENCE     �   ALTER TABLE dbo."Users" ALTER COLUMN "UserId" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dbo."Users_UserId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            dbo          postgres    false    225    6            [          0    82263    Access 
   TABLE DATA           Z   COPY dbo."Access" ("AccessId", "Name", "AccessPages", "Active", "AccessCode") FROM stdin;
    dbo          postgres    false    215   �_       ]          0    82285    Files 
   TABLE DATA           ;   COPY dbo."Files" ("FileId", "FileName", "Url") FROM stdin;
    dbo          postgres    false    217   �`       _          0    82291    GatewayConnectedUsers 
   TABLE DATA           J   COPY dbo."GatewayConnectedUsers" ("Id", "SocketId", "UserId") FROM stdin;
    dbo          postgres    false    219   �`       a          0    82295    Notifications 
   TABLE DATA           �   COPY dbo."Notifications" ("NotificationId", "Title", "Description", "Type", "ReferenceId", "IsRead", "UserId", "Date") FROM stdin;
    dbo          postgres    false    221   �`       j          0    82539    Room 
   TABLE DATA           �   COPY dbo."Room" ("RoomId", "RoomNumber", "RoomTypeId", "AdultCapacity", "ChildrenCapacity", "RoomRate", "DateAdded", "DateLastUpdated", "Status", "Active", "ThumbnailFileId") FROM stdin;
    dbo          postgres    false    230   �`       l          0    82560    RoomBooking 
   TABLE DATA           �   COPY dbo."RoomBooking" ("RoomBookingId", "RoomBookingCode", "BookedByUserId", "RoomId", "DateCreated", "DateLastUpdated", "CheckInDate", "CheckOutDate", "RoomRateAmount", "OtherCharges", "TotalAmount", "Status", "Guest") FROM stdin;
    dbo          postgres    false    232   a       h          0    82493    RoomType 
   TABLE DATA           �   COPY dbo."RoomType" ("RoomTypeId", "RoomTypeCode", "Name", "Active", "DateAdded", "DateLastUpdated", "ThumbnailFileId") FROM stdin;
    dbo          postgres    false    228   /a       c          0    82341    SystemConfig 
   TABLE DATA           5   COPY dbo."SystemConfig" ("Key", "Value") FROM stdin;
    dbo          postgres    false    223   La       d          0    82368    UserProfilePic 
   TABLE DATA           ;   COPY dbo."UserProfilePic" ("UserId", "FileId") FROM stdin;
    dbo          postgres    false    224   ia       e          0    82371    Users 
   TABLE DATA           �   COPY dbo."Users" ("UserId", "UserName", "Password", "FullName", "Gender", "BirthDate", "MobileNumber", "AccessGranted", "AccessId", "Active", "UserCode", "Address", "UserType", "Email", "ConfirmationCode", "ConfirmationComplete") FROM stdin;
    dbo          postgres    false    225   �a       s           0    0    Access_AccessId_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('dbo."Access_AccessId_seq"', 1, true);
          dbo          postgres    false    216            t           0    0    Files_FileId_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('dbo."Files_FileId_seq"', 1, false);
          dbo          postgres    false    218            u           0    0    GatewayConnectedUsers_Id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('dbo."GatewayConnectedUsers_Id_seq"', 1, false);
          dbo          postgres    false    220            v           0    0     Notifications_NotificationId_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('dbo."Notifications_NotificationId_seq"', 1, false);
          dbo          postgres    false    222            w           0    0    RoomBooking_RoomBookingId_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('dbo."RoomBooking_RoomBookingId_seq"', 1, false);
          dbo          postgres    false    231            x           0    0    RoomType_RoomTypeId_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('dbo."RoomType_RoomTypeId_seq"', 1, false);
          dbo          postgres    false    227            y           0    0    Room_RoomId_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('dbo."Room_RoomId_seq"', 1, false);
          dbo          postgres    false    229            z           0    0    Users_UserId_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('dbo."Users_UserId_seq"', 1, true);
          dbo          postgres    false    226            �           2606    82381    Access Access_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY dbo."Access"
    ADD CONSTRAINT "Access_pkey" PRIMARY KEY ("AccessId");
 =   ALTER TABLE ONLY dbo."Access" DROP CONSTRAINT "Access_pkey";
       dbo            postgres    false    215            �           2606    82385     Notifications Notifications_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY dbo."Notifications"
    ADD CONSTRAINT "Notifications_pkey" PRIMARY KEY ("NotificationId");
 K   ALTER TABLE ONLY dbo."Notifications" DROP CONSTRAINT "Notifications_pkey";
       dbo            postgres    false    221            �           2606    82574    RoomBooking RoomBooking_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY dbo."RoomBooking"
    ADD CONSTRAINT "RoomBooking_pkey" PRIMARY KEY ("RoomBookingId");
 G   ALTER TABLE ONLY dbo."RoomBooking" DROP CONSTRAINT "RoomBooking_pkey";
       dbo            postgres    false    232            �           2606    82501    RoomType RoomType_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY dbo."RoomType"
    ADD CONSTRAINT "RoomType_pkey" PRIMARY KEY ("RoomTypeId");
 A   ALTER TABLE ONLY dbo."RoomType" DROP CONSTRAINT "RoomType_pkey";
       dbo            postgres    false    228            �           2606    82551    Room Room_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY dbo."Room"
    ADD CONSTRAINT "Room_pkey" PRIMARY KEY ("RoomId");
 9   ALTER TABLE ONLY dbo."Room" DROP CONSTRAINT "Room_pkey";
       dbo            postgres    false    230            �           2606    82395    SystemConfig SystemConfig_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY dbo."SystemConfig"
    ADD CONSTRAINT "SystemConfig_pkey" PRIMARY KEY ("Key");
 I   ALTER TABLE ONLY dbo."SystemConfig" DROP CONSTRAINT "SystemConfig_pkey";
       dbo            postgres    false    223            �           2606    82399    Files pk_files_901578250 
   CONSTRAINT     [   ALTER TABLE ONLY dbo."Files"
    ADD CONSTRAINT pk_files_901578250 PRIMARY KEY ("FileId");
 A   ALTER TABLE ONLY dbo."Files" DROP CONSTRAINT pk_files_901578250;
       dbo            postgres    false    217            �           2606    82401 8   GatewayConnectedUsers pk_gatewayconnectedusers_933578364 
   CONSTRAINT     w   ALTER TABLE ONLY dbo."GatewayConnectedUsers"
    ADD CONSTRAINT pk_gatewayconnectedusers_933578364 PRIMARY KEY ("Id");
 a   ALTER TABLE ONLY dbo."GatewayConnectedUsers" DROP CONSTRAINT pk_gatewayconnectedusers_933578364;
       dbo            postgres    false    219            �           2606    82403 -   UserProfilePic pk_userprofilepic_1_1525580473 
   CONSTRAINT     p   ALTER TABLE ONLY dbo."UserProfilePic"
    ADD CONSTRAINT pk_userprofilepic_1_1525580473 PRIMARY KEY ("UserId");
 V   ALTER TABLE ONLY dbo."UserProfilePic" DROP CONSTRAINT pk_userprofilepic_1_1525580473;
       dbo            postgres    false    224            �           2606    82405    Users pk_users_1557580587 
   CONSTRAINT     \   ALTER TABLE ONLY dbo."Users"
    ADD CONSTRAINT pk_users_1557580587 PRIMARY KEY ("UserId");
 B   ALTER TABLE ONLY dbo."Users" DROP CONSTRAINT pk_users_1557580587;
       dbo            postgres    false    225            �           1259    82557    u_room_number    INDEX     �   CREATE UNIQUE INDEX u_room_number ON dbo."Room" USING btree ("RoomNumber", "Active") WITH (deduplicate_items='false') WHERE ("Active" = true);
    DROP INDEX dbo.u_room_number;
       dbo            postgres    false    230    230    230            �           1259    82409    u_user_number    INDEX     �   CREATE UNIQUE INDEX u_user_number ON dbo."Users" USING btree ("MobileNumber", "Active") WITH (deduplicate_items='false') WHERE ("Active" = true);
    DROP INDEX dbo.u_user_number;
       dbo            postgres    false    225    225    225            �           1259    82410 
   u_username    INDEX     �   CREATE UNIQUE INDEX u_username ON dbo."Users" USING btree ("UserName", "Active") WITH (deduplicate_items='false') WHERE ("Active" = true);
    DROP INDEX dbo.u_username;
       dbo            postgres    false    225    225    225            �           2606    82411 3   GatewayConnectedUsers fk_GatewayConnectedUsers_User    FK CONSTRAINT     �   ALTER TABLE ONLY dbo."GatewayConnectedUsers"
    ADD CONSTRAINT "fk_GatewayConnectedUsers_User" FOREIGN KEY ("UserId") REFERENCES dbo."Users"("UserId");
 ^   ALTER TABLE ONLY dbo."GatewayConnectedUsers" DROP CONSTRAINT "fk_GatewayConnectedUsers_User";
       dbo          postgres    false    219    3257    225            �           2606    82416    Users fk_User_Access    FK CONSTRAINT     �   ALTER TABLE ONLY dbo."Users"
    ADD CONSTRAINT "fk_User_Access" FOREIGN KEY ("AccessId") REFERENCES dbo."Access"("AccessId") NOT VALID;
 ?   ALTER TABLE ONLY dbo."Users" DROP CONSTRAINT "fk_User_Access";
       dbo          postgres    false    225    215    3245            �           2606    82431 #   Notifications fk_notifications_user    FK CONSTRAINT     �   ALTER TABLE ONLY dbo."Notifications"
    ADD CONSTRAINT fk_notifications_user FOREIGN KEY ("UserId") REFERENCES dbo."Users"("UserId") NOT VALID;
 L   ALTER TABLE ONLY dbo."Notifications" DROP CONSTRAINT fk_notifications_user;
       dbo          postgres    false    225    221    3257            �           2606    82552    Room fk_room_roomtype    FK CONSTRAINT     �   ALTER TABLE ONLY dbo."Room"
    ADD CONSTRAINT fk_room_roomtype FOREIGN KEY ("RoomTypeId") REFERENCES dbo."RoomType"("RoomTypeId");
 >   ALTER TABLE ONLY dbo."Room" DROP CONSTRAINT fk_room_roomtype;
       dbo          postgres    false    230    3261    228            �           2606    82624    Room fk_room_thumbnailfile    FK CONSTRAINT     �   ALTER TABLE ONLY dbo."Room"
    ADD CONSTRAINT fk_room_thumbnailfile FOREIGN KEY ("ThumbnailFileId") REFERENCES dbo."Files"("FileId") NOT VALID;
 C   ALTER TABLE ONLY dbo."Room" DROP CONSTRAINT fk_room_thumbnailfile;
       dbo          postgres    false    230    3247    217            �           2606    82580 )   RoomBooking fk_roombooking_bookedbyuserid    FK CONSTRAINT     �   ALTER TABLE ONLY dbo."RoomBooking"
    ADD CONSTRAINT fk_roombooking_bookedbyuserid FOREIGN KEY ("BookedByUserId") REFERENCES dbo."Users"("UserId");
 R   ALTER TABLE ONLY dbo."RoomBooking" DROP CONSTRAINT fk_roombooking_bookedbyuserid;
       dbo          postgres    false    232    3257    225            �           2606    82575    RoomBooking fk_roombooking_room    FK CONSTRAINT     �   ALTER TABLE ONLY dbo."RoomBooking"
    ADD CONSTRAINT fk_roombooking_room FOREIGN KEY ("RoomId") REFERENCES dbo."Room"("RoomId");
 H   ALTER TABLE ONLY dbo."RoomBooking" DROP CONSTRAINT fk_roombooking_room;
       dbo          postgres    false    3263    230    232            �           2606    82502 "   RoomType fk_roomtype_thumbnailfile    FK CONSTRAINT     �   ALTER TABLE ONLY dbo."RoomType"
    ADD CONSTRAINT fk_roomtype_thumbnailfile FOREIGN KEY ("ThumbnailFileId") REFERENCES dbo."Files"("FileId");
 K   ALTER TABLE ONLY dbo."RoomType" DROP CONSTRAINT fk_roomtype_thumbnailfile;
       dbo          postgres    false    217    3247    228            �           2606    82481 0   UserProfilePic fk_userprofilepic_files_354100302    FK CONSTRAINT     �   ALTER TABLE ONLY dbo."UserProfilePic"
    ADD CONSTRAINT fk_userprofilepic_files_354100302 FOREIGN KEY ("FileId") REFERENCES dbo."Files"("FileId");
 Y   ALTER TABLE ONLY dbo."UserProfilePic" DROP CONSTRAINT fk_userprofilepic_files_354100302;
       dbo          postgres    false    224    217    3247            �           2606    82486 &   UserProfilePic fk_userprofilepic_users    FK CONSTRAINT     �   ALTER TABLE ONLY dbo."UserProfilePic"
    ADD CONSTRAINT fk_userprofilepic_users FOREIGN KEY ("UserId") REFERENCES dbo."Users"("UserId");
 O   ALTER TABLE ONLY dbo."UserProfilePic" DROP CONSTRAINT fk_userprofilepic_users;
       dbo          postgres    false    3257    224    225            [   �   x�3�tL���㌎�S �jCAA� 1=U�JA�%�8#)?�(EII�,3�([RT��,�����V�E�(3=��(���g�S~~vf^��GfqI~Q%�,Wr,((�/K�Q"�A�����8�F��ʂT�ZZ�ZTL+ҋ�K�n/��Y�i �\1z\\\ ab��      ]      x������ � �      _      x������ � �      a      x������ � �      j      x������ � �      l      x������ � �      h      x������ � �      c      x������ � �      d      x������ � �      e   �   x�3�LL����T1JR14P�)�3ήJKO��0Hs�rK1IM	u+�0�)5O���Huqq�-��v-t�J�+�H�t� &9�]�\\�8---t�u-8��ML�8K8�� 9�9�C�� �;�I���\N��=... ��*d     