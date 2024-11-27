PGDMP     ,                
    |            cafe2    15.2    15.2     '           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            (           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            )           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            *           1262    35579    cafe2    DATABASE     �   CREATE DATABASE cafe2 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE cafe2;
                postgres    false            V           1247    35588 
   cafe_style    TYPE     z   CREATE TYPE public.cafe_style AS ENUM (
    'modern',
    'traditional',
    'vintage',
    'outdoor',
    'workspace'
);
    DROP TYPE public.cafe_style;
       public          postgres    false            Y           1247    35600 
   drink_type    TYPE     p   CREATE TYPE public.drink_type AS ENUM (
    'coffee',
    'tea',
    'smoothie',
    'juice',
    'cocktail'
);
    DROP TYPE public.drink_type;
       public          postgres    false            S           1247    35581    price_range    TYPE     P   CREATE TYPE public.price_range AS ENUM (
    'low',
    'medium',
    'high'
);
    DROP TYPE public.price_range;
       public          postgres    false            �            1255    35639    update_timestamp()    FUNCTION     �   CREATE FUNCTION public.update_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.update_timestamp();
       public          postgres    false            �            1259    35612    cafes    TABLE     #  CREATE TABLE public.cafes (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    address text NOT NULL,
    image_urls text[],
    price_range public.price_range NOT NULL,
    style public.cafe_style NOT NULL,
    google_rating numeric(2,1),
    opening_time time without time zone NOT NULL,
    closing_time time without time zone NOT NULL,
    distance_from_sun numeric(5,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.cafes;
       public         heap    postgres    false    854    851            �            1259    35611    cafes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cafes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.cafes_id_seq;
       public          postgres    false    217            +           0    0    cafes_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.cafes_id_seq OWNED BY public.cafes.id;
          public          postgres    false    216            �            1259    35623    drinks    TABLE     �  CREATE TABLE public.drinks (
    id integer NOT NULL,
    cafe_id integer NOT NULL,
    name character varying(100) NOT NULL,
    type public.drink_type NOT NULL,
    price numeric(10,2) NOT NULL,
    description text,
    image_url text,
    is_available boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.drinks;
       public         heap    postgres    false    857            �            1259    35622    drinks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.drinks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.drinks_id_seq;
       public          postgres    false    219            ,           0    0    drinks_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.drinks_id_seq OWNED BY public.drinks.id;
          public          postgres    false    218            �           2604    35615    cafes id    DEFAULT     d   ALTER TABLE ONLY public.cafes ALTER COLUMN id SET DEFAULT nextval('public.cafes_id_seq'::regclass);
 7   ALTER TABLE public.cafes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    35626 	   drinks id    DEFAULT     f   ALTER TABLE ONLY public.drinks ALTER COLUMN id SET DEFAULT nextval('public.drinks_id_seq'::regclass);
 8   ALTER TABLE public.drinks ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219            "          0    35612    cafes 
   TABLE DATA           �   COPY public.cafes (id, name, address, image_urls, price_range, style, google_rating, opening_time, closing_time, distance_from_sun, created_at, updated_at) FROM stdin;
    public          postgres    false    217   F       $          0    35623    drinks 
   TABLE DATA           ~   COPY public.drinks (id, cafe_id, name, type, price, description, image_url, is_available, created_at, updated_at) FROM stdin;
    public          postgres    false    219   �       -           0    0    cafes_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.cafes_id_seq', 22, true);
          public          postgres    false    216            .           0    0    drinks_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.drinks_id_seq', 255, true);
          public          postgres    false    218            �           2606    35621    cafes cafes_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.cafes
    ADD CONSTRAINT cafes_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.cafes DROP CONSTRAINT cafes_pkey;
       public            postgres    false    217            �           2606    35633    drinks drinks_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.drinks
    ADD CONSTRAINT drinks_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.drinks DROP CONSTRAINT drinks_pkey;
       public            postgres    false    219            �           2620    35640    cafes trigger_update_timestamp    TRIGGER        CREATE TRIGGER trigger_update_timestamp BEFORE UPDATE ON public.cafes FOR EACH ROW EXECUTE FUNCTION public.update_timestamp();
 7   DROP TRIGGER trigger_update_timestamp ON public.cafes;
       public          postgres    false    217    228            �           2606    35634    drinks drinks_cafe_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.drinks
    ADD CONSTRAINT drinks_cafe_id_fkey FOREIGN KEY (cafe_id) REFERENCES public.cafes(id) ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.drinks DROP CONSTRAINT drinks_cafe_id_fkey;
       public          postgres    false    217    3214    219            "   i  x�ŖOo�D���O�A����o�J�@Z�j�JHH��q�)�L��M+�	!{�=!��ZB[	��@}t���o�8i����ndE�'����y�!�ifQ� c���`�^��������ś�������V}W�Dy����$E3�ZM��3H��{{u�\?�>�ٌ��~V��౾�F4�R������e���G�����f}���h���d�X��`\ٙʴ���0r'��4��N1ʀuN�cP�ӳ;�y�Yd��a�}$�/Q1^�脋\���������5nn�n���&!�ԁf�٢D7�c�tm��-�u���E�L�s��
�@?��~pp���^��e$��B͂���uK��G��eb�@*Y�	�D��7 �- 5���0:E������mv�V����5�[��~]~��A�_��=tf'Rխ! :i���!8��%�[ v뫋����O��ʶ�"gRf�h|G�X�Nˢ-t����9�O6K[ωw Ľ��ɀc�$��s.E0|+����V����{�-�O��Q!��Ǫ#����Náz	,�=�~��<W�g
��ʤ�	"�nbrmZ�O�K��:�`G%h]^_�|v�x��5J�S�ZD�i��9D<)�zȊ�� ��&��xK�4�o�0��i[Mxh��쨂FIu���D�"��i�o?��[�AP��DnvW�����T�����A�U����8�7�'A㆞2E����'k�[]��z*X����i���Q��w�X:N����UB��1�Ha搏<�"7�s��?Նǳ��LLd�y�%��xIv|:�3�4����QF3�x��j�O��􍍍 ��      $   �  x�՝�n�FƯ�����F����Ɋ�8���]��@S�D[$e��-��b�ZlzQ���t�h�]`��*�z���)���G���� �O�s�̜�3�^c�]'vNmDQ<𽚩+��XQj_�k�8M>�����;��=?tƳ�n�{��#׉�A���W����ӫ�SSe&�[����P���^�/���'�~-�1�i�P�	��B?��SE}�*�fя���ਝ��tj)Pu�w���=9)�j�U�/�y6v�pBv�8���l�uO߿�XM�u�p@�����hq�M�,@�X����s�N/�S�m��rܧ~@Φ���c<:�J�R�����v�EZ�Z�95k3�Z��A/��f�`)��i�����u����W��q�g���Ш�݉9�ãb�*'<�ۆ�iu�;S��#�X�e<�6׉��V0B���4D�=��pǿ��%���_�>9�����i�)�o_��D�u2Yܼ���mf�����oF�7��h���U�[���7���o$�^Q����y���t�jnt|�yV�0���=���^Q���nk��h�U�Sq�O�E4m�=}�j����A+�40�n�	w:�)�i��*0/_5�o��Ұ0�
��й�]��u��ͽ���,)x1��wO��+�XlR�E�FS���(�]PޣRIy<Ov#q'c�H�����ǴA� RU��c'��d�q݁���I��a}/�L��(O�ŉ$]�`�/O>y�q�1�m�ɯ��ʽtq@iMFa���Z���19EWs[���oFRD�ژ,Ny��p�av9A�5�;YVM!�#��픟�0%e�%y����'���/ȋW��y�|���'�Yc�E�@������ë�ݭ�>�����N�Q�d�|�mȧ����zr2�/
}({��������X{���3���V)L[0���g��+v[0�g[�&_�s3�LR�u�ӓ�YTٔg^��e��5/����I�۹f�M{��C����K��8/��5����+hy�l��F��ϋ��\�ϙ���kjr�>�=�dM����gVx�~Dz���Z����2�
�ZV��O'�%��������yLd�{�Ɠ=�y����.4�Nx��	�]��Ƌ��0���j��e!�k9����}�&:��k��p0�?(�f+�8=�W���N�
��ճL:�������^v��l�g�Y�+e��ך����e�����qJ�|�!����*鬔_x��և���tw��������+�P8�������*�׿$F<����Al�o��#�y<����?��o��5L�V��Տ �Z�5�T��5N��W��x$R�ɩ�x��Qa?!��5�Dg�8H�p�
�PT��wg}�9+�y��Q篹��Жl�Т'�kݫ���hQa+#�U�U�r�Q��t�2�&G��1ԓhF�{��֯b ���2ޣ+�X��^�\��Q+�^�2���R�>YKڪ٪���Re٪e����dZQ]�����M5��T�6jӔ5w�Â�9Tw�-�ѹ\��ee K�UH���9IG�������A&K5q[�v��rќ s�K9�o�ϛxhV��j���%g�\%tgD��a����4�� K���%]�jU�aq�{� hYa>e��e��Z��ʹL%<Y���HC �ï2ْ4J,�r5E���m?����_V @���*����}�w��K>��G`jxQVwp�J.��i�d�e���ʫb)f�-Q��p{󷳪�0�nY.7^]p�hsC��V�C/JY�j�8�<��#n�O��xu�!�9n�a:���s���J�A�2�"LyH��	�8��1�����ʯ��JI`fw��������])�\�$��v��׬ZG)����!���� �#�Hiԫ�'�W+m��?_�~;Z��'Xsӊ.�kvn�#7�z5��f�*�e_ޙ.��-�J���A$V9:��I��pSQmA/+�K�Fy�������}J��Ƞ����)��wɼ��(�k��;�dS�b�k8����v�Yk��]�b7M;�:���jܪ����H�B�z���Y�S��,��۪����xzT,媉~ĭ��N��E*�������X繞6r����/���]�T
�7�����PC �S4~bK����H�!��Ғ��)�H`,n~�I�����b���V�ӵrI*{3��y��Իs����rm!W�2̂�sYb����A"/��(�P�lO��%���T*Hw�"�9� �S�jA���eh�PW3��0�%g��j~��f	�D�%%|"��Yܼ#��/�"�b�W�7�e6eǋJ�F	�,�Ei�����`�{�‿}�i��~qu:0
��,{��uAIF|�|tw�a���t��j����q��䞊}ŤL1����J��0~TI����iKF�"�b�Ȳ��>䊉��ɽ�)9P��]0+9)dDG��(;��^��TGU����7�fv��iΘ&�����*�m����n�4Q�W���RRdn	c�Ġi�j������+Dfi1K5
����͢1\�7�4הTז'hb	�5�<�猇�?�f�)��t�a�a��z.#UL��J�Q�3!U&�ȟ��	p�a�S�\w�e���;�Bl1*�Ï���7�[#싷�.�y��LJ
�֩fm4����
�VR�Nq�e��E�X�J���X#�w"p�-Ȼ�I�V��Za�FM��f�At��(g������n�J0�\��m����=&]��)�
��ꅥ�Õ?&�����E���o�bWk�����6Pr���ʩ���(�(40j��tv��
U��fT�ۃ(S$��	�Q�_|"R��$Ɗ>�>qH> ��y��w.Zq'^%FE�p��kY2�l1yf��3����V�(E ��UuU/�L���
4�X5mU�[M��P��+��@��� ��#��e������C�mف�cJ�����^so�q�ڜ��y� Uy43����x��xc�u֓�A��[iL�I��U̸�U�@�6C�S�{�_��z��P{>:1�|��}3�@q��3ZL��~�$O<�5��C�x��{dk�]�!A���<k~~ARUN��� �_�Х0�c�4Kߘ ���LgY�;�xp���.�
�ס������n����K6����Gx�<�@@.i(ه76�3A��\�3>����3ZF:��980�D���IH(����)���0�8���B�V&,J_G�܈M%��z��
�j���r⤊�z�j��I�#5S�	4Mb��o�,�#b��k�Ls#C�*�;�.U�y��YR�U�-��*�(�r,[T���(8�"l*�ՙ ��Ia`��D�7�g��*�[]�5JiA�o�2�*)���!Q?Fir��A���15�J/A@�o2-�Z����o�(e
�a�Nf�e.�2B�*M�)����u-�h���Ak����.�:�ܛ������	Sz+��F��͗�����R��3E�k2�a�_�vdl>9���W��5�,�J�_��J�ZC�Ey�"2j���uR�8CԷN+7D6��ٚ�jLC3kz=?���Dfm)���,��S*2��
QT/�e�|��(�Ե����ͪv��̩���.�|�*Fu��0�$���i�˼͊j�C�
y�Nk��Jzx=���L�/!w��"3���oTj������
�OK�S��E5�����)������k >D�ª���ލ��HF��9��G@�3U-Y�(I��eU�a�3�u��;�j���f�b���!���n���wp/|e#�%:���A��u�D��XWT�5x��%���$��Hm�b�g^�Lƻ�x12|���%:�e�R����2R{�/T��������nj=*��уQ�9?��!�����<#NՍq��"K�7vF����U�ԙ����뗨o�+�'��@vB��K�秶'��y�Fi[�QZ�3���<x�?4i�     