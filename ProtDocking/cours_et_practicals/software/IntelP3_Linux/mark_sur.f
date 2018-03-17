CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
C f77 mark_sur.f -o mark_sur -O3                                           C
C This program is going to calculate the VDW surface area mark the surface C
C residues at the occupancy column                                         C
C If the area of one atom is greater than 1.0, the atom is marked "1"      C
C as on the surface.                                                       C
C The atom type is also marked.  Currently using Chao's 18 types + HOH =19 C
C IACC=0: calculate the van der Waals Area                                 C
C The radius of water is 1.4A.                                             C
C                                                                          C
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

	integer      MATM,ATM_TYPE
        parameter    (MATM=80000,ATM_TYPE=2000)

	character*4  rtf_res_name(ATM_TYPE), rtf_atm_name(ATM_TYPE)
	real         rtf_rad(ATM_TYPE),rtf_chg(ATM_TYPE)
        integer      rtf_Chao_id(ATM_TYPE)
        integer      tot_atm_type
        character*80 line

        character*4  res_name(MATM),atm_name(MATM), segid(MATM)
        character*1  chainid(MATM)
        integer      res_num(MATM), atm_num(MATM), atm_t(MATM)
        integer      tot_res,tot_atm,ia,ir,ia2,sur(MATM),sur_atm(MATM)
        real         x(MATM), y(MATM), z(MATM), rad(MATM), area(MATM)
	real         chg(MATM), rad_smpl(MATM)
        CHARACTER*80 ARG
        INTEGER      NARG

C===========================================================================

        NARG = iargc()
        if(NARG.ne.2) then
          write(*,1)
1         FORMAT('Usage: mark_sur in_pdb_file out_pdb_file')
          write(*,2)
2         FORMAT('Mark the surface residues of a PDB file')
          stop
        end if

        call getarg(1,ARG)
        OPEN(UNIT=10,FILE=ARG,STATUS='old')
        call getarg(2,ARG)
        OPEN(UNIT=11,FILE=ARG,STATUS='unknown')
	OPEN(UNIT=12,FILE='uniCHARMM', 
     &       STATUS='old')

	tot_atm_type = 0
        ia = 1
	do while (.true.)
	   read(12,'(A80)', end=1000) line
	   read(line,5) rtf_res_name(ia),rtf_atm_name(ia),
     &         rtf_rad(ia),rtf_chg(ia),rtf_Chao_id(ia)

5	   FORMAT(a4,1x,a4,1x,f4.2,1x,f5.2,1x,i2)
C  ARGN N    1.63 -0.15  1
	   ia = ia + 1
        end do
1000	tot_atm_type = ia - 1

	call readin(tot_atm_type,rtf_res_name,rtf_atm_name,rtf_rad,
     &              rtf_chg,rtf_Chao_id,tot_res,tot_atm,res_name,
     &              atm_name,chainid,res_num,atm_num,atm_t,x,y,z,
     &              segid,rad_smpl,rad,chg)
	   
 	call get_area(tot_atm,x,y,z,rad_smpl,area)

        do ia = 1, tot_atm
           sur(ia) = 0
           sur_atm(ia) = 0
        end do

        do ia = 1, tot_atm 
           if(area(ia) .gt. 1) then
              ir = res_num(ia)
              sur_atm(ia) = 1
              do ia2 = 1, tot_atm
                 if (res_num(ia2) .eq. ir) sur(ia2) = 1
              end do
           end if
        end do

        do ia = 1, tot_atm

           write(11,3) atm_num(ia),atm_name(ia),res_name(ia),
     &                 chainid(ia),res_num(ia),x(ia),y(ia),z(ia),
     &                 atm_t(ia),sur_atm(ia),rad(ia),
     &                 segid(ia),chg(ia)
3          FORMAT('ATOM',2x,i5,2x,a4,a4,a1,i4,4x,3f8.3,1x,i2,4x,i2,
     &1x,f4.2,4x,a4,1x,f5.2)
        end do
        stop 
        end

c************************************************************************
c  read in the pdb file
c ************************************************************************

      SUBROUTINE readin(tot_atm_type,rtf_res_name,rtf_atm_name,rtf_rad,
     &              rtf_chg,rtf_Chao_id,tot_res,tot_atm,res_name,
     &              atm_name,chainid,res_num,atm_num,atm_t,x,y,z,
     &              segid,rad_smpl,rad,chg)

      integer      MATM,ATM_TYPE
      parameter    (MATM=80000,ATM_TYPE=2000)

      character*4  rtf_res_name(ATM_TYPE), rtf_atm_name(ATM_TYPE)
      real         rtf_rad(ATM_TYPE),rtf_chg(ATM_TYPE)
      integer      rtf_Chao_id(ATM_TYPE)
      integer      tot_atm_type, it

      character*4  res_name(MATM)
      character*1  chainid(MATM)
      character*4  atm_name(MATM), segid(MATM)
      integer      res_num(MATM), atm_num(MATM), atm_t(MATM)
      integer      tot_res, tot_atm, ir, ia
      real         x(MATM), y(MATM), z(MATM)
      real         rad(MATM), rad_smpl(MATM), chg(MATM)
      character*80 line

      ir = 1
      ia = 1

      do while (.true.)

         read(10,'(A80)', end=1000) line
         if(line(1:4).ne.'ATOM' .and. line(1:6).ne.'HETATM') then
            if (line(1:3) .ne. 'END')  write(11,'(A80)') line
            goto 999
         end if

         read(line,3) atm_num(ia),atm_name(ia),res_name(ia),
     &         chainid(ia),res_num(ia),x(ia),y(ia),z(ia),segid(ia)
        
3        FORMAT(6x,i5,2x,a4,a4,a1,i4,4x,3f8.3,18x,a4)
cATOM   2080  N   ARGNA  20       6.563 -17.692 -10.548  1  1  1         2SNI

         do it = 1, tot_atm_type
	    if ((res_name(ia) .eq. rtf_res_name(it)) .and. (atm_name(ia) 
     &         .eq. rtf_atm_name (it))) then
		atm_t(ia) = rtf_Chao_id(it)
		rad(ia) = rtf_rad(it)
		chg(ia) = rtf_chg(it)
                goto 100
            end if
         end do
C Unknown type
	 atm_t(ia) = 0
	 rad(ia) = 1.9
         chg(ia) = 0
         write(*,4) ia, res_name(ia), atm_name(ia)
4	 FORMAT(i5,1x,a4,1x,a4,'unknown type.  rad set to 1.9, chg 0')

100	 continue

C simple way of assigning the atom radius.  Unknown is treated as C.
         if (atm_name(ia)(1:1) .eq. "C") then
            rad_smpl(ia) = 1.9
         else if (atm_name(ia)(1:1) .eq. "N") then
            rad_smpl(ia) = 1.7
         else if (atm_name(ia)(1:1) .eq. "O") then
            rad_smpl(ia) = 1.4
         else if (atm_name(ia)(1:1) .eq. "S") then
            rad_smpl(ia) = 1.8
         else if (atm_name(ia)(1:1) .eq. "H") then
            rad_smpl(ia) = 0.8
         else
            rad_smpl(ia) = 1.9
         end if

         if (ia .gt. 1 .and. (res_name(ia) .ne. res_name(ia-1)
     &       .or. res_num(ia) .ne. res_num(ia-1) .or.
     &       segid(ia) .ne. segid(ia-1) ) ) ir = ir +1
         ia = ia + 1

999   end do

1000  tot_res = ir - 1
      tot_atm = ia - 1

      return
      end

c ************************************************************************
c  Compute the Surface Area of a Atom Set
c ************************************************************************

      SUBROUTINE get_area(tot_atm,x,y,z,rad,atarea)

c  Constant and variable
c  ATOM property: X,Y,Z,RAD,CUBE,SEQNO,AATYP,res_atmname,RADSQ
c  CONTACT:       INOV,TAG,ARCI,ARCF,DX,DY,D,DSQ
c  CUBE porperty: ITAB,NATM

      INTEGER     NCUBE,NAC,NSATM,ICT
      PARAMETER   (NCUBE=3500,NAC=1000)
      PARAMETER   (NSATM=10000,ICT=1000)

      INTEGER 	  tot_atm,IACC
      REAL	  X(*), Y(*), Z(*)
      REAL        RAD(*), RADSQ(NSATM), ATAREA(*)
      INTEGER	  INOV(ICT), TAG(ICT)
      REAL	  ARCI(ICT), ARCF(ICT)
      REAL	  DX(ICT),DY(ICT),D(ICT),DSQ(ICT)
      INTEGER     ITAB(NCUBE), NATM(NAC,NCUBE), CUBE(NSATM)

      real  XMIN,YMIN,ZMIN,XMAX,YMAX,ZMAX
C**   NumberofSlices: 1/P, WaterRadii:1.40 

      real  P,RH2O

      IACC = 1

      XMIN= 9999.9
      YMIN= 9999.9
      ZMIN= 9999.9
      XMAX= -9999.9
      YMAX= -9999.9
      ZMAX= -9999.9
      P   = 0.01
      RH2O= 1.40
      PI  = ACOS(-1.0)
      PIX2= 2.0*PI
	
      if(atm_num.gt.NSATM)  stop 'INCREASE NSATM'
     
C** THE RADIUS OF AN ATOM SPHERE = ATOM RADIUS + PROBE RADIUS
      RMAX=0.0
      KARC=ICT
      DO I = 1,tot_atm
	 IF(x(i) .gt. -9990. .and. x(i) .lt. 9990. .and.
     &      y(i) .gt. -9990. .and. y(i) .lt. 9990. .and.
     &      z(i) .gt. -9990. .and. z(i) .lt. 9990.) then
            RAD(I)=RAD(I)+RH2O
            RADSQ(I)=RAD(I)**2
            IF(RAD(I).GT.RMAX)RMAX=RAD(I)
            IF(XMIN.GT.X(I))XMIN=X(I)
            IF(YMIN.GT.Y(I))YMIN=Y(I)
            IF(ZMIN.GT.Z(I))ZMIN=Z(I)
            IF(XMAX.LT.X(I))XMAX=X(I)
            IF(YMAX.LT.Y(I))YMAX=Y(I)
            IF(ZMAX.LT.Z(I))ZMAX=Z(I)
	 ENDIF
      ENDDO
      DMAX=RMAX*2.
      IF(IACC.NE.0) RH2O=0.0

C** CUBICALS CONTAINING THE ATOMS ARE SETUP. THE DIMENSION OF AN EDGE EQUALS
C** THE RADIUS OF THE LARGEST ATOM SPHERE
C** THE CUBES HAVE A SINGLE INDEX
      IDIM=(XMAX-XMIN)/DMAX+1.
      IF(IDIM.LT.3)IDIM=3
      JIDIM=(YMAX-YMIN)/DMAX+1.
      IF(JIDIM.LT.3)JIDIM=3
      JIDIM=IDIM*JIDIM
      KJIDIM=(ZMAX-ZMIN)/DMAX+1.
      IF(KJIDIM.LT.3)KJIDIM=3
      KJIDIM=JIDIM*KJIDIM
      if(KJIDIM.gt.NCUBE) stop 'INCREASE NCUBE'

C** PREPARE UPTO NCUBE CUBES EACH CONTAINING UPTO NAC ATOMS. THE CUBE INDEX
C** IS KJI. THE ATOM INDEX FOR EACH CUBE IS IN ITAB
      DO L=1,NCUBE
         ITAB(L)=0
      ENDDO

      DO L=1,tot_atm
         IF(x(l) .gt. -9990. .and. x(l) .lt. 9990. .and.
     &      y(l) .gt. -9990. .and. y(l) .lt. 9990. .and.
     &      z(l) .gt. -9990. .and. z(l) .lt. 9990.) then
            I=(X(L)-XMIN)/DMAX+1.
            J=(Y(L)-YMIN)/DMAX
            K=(Z(L)-ZMIN)/DMAX
            KJI=K*JIDIM+J*IDIM+I
            N=ITAB(KJI)+1
	    if(N.gt.NAC) stop 'INCREASE NAC'
            ITAB(KJI)=N
            NATM(N,KJI)=L
            CUBE(L)=KJI
	 ENDIF
      ENDDO

C** PROCESS EACH ATOM
      DO 5 IR = 1, tot_atm
      IF(x(ir) .lt. -9990. .or. x(ir) .gt. 9990. .or.
     &   y(ir) .lt. -9990. .or. y(ir) .gt. 9990. .or.
     &   z(ir) .lt. -9990. .or. z(ir) .gt. 9990.) goto 5
      KJI=CUBE(IR)
      IO=0
      AREA=0.
      XR=X(IR)
      YR=Y(IR)
      ZR=Z(IR)
      RR=RAD(IR)
      RRX2=RR*2.
      RRSQ=RADSQ(IR)

C** FIND THE 'MKJI' CUBES NEIGHBORING THE KJI CUBE
      DO 6 KK=1,3
      K=KK-2
      DO 6 JJ=1,3
      J=JJ-2
      DO 6 I=1,3
         MKJI=KJI+K*JIDIM+J*IDIM+I-2
         IF(MKJI.LT.1) GO TO 6
         IF(MKJI.GT.KJIDIM) GO TO 14
         NM=ITAB(MKJI)
         IF(NM.LT.1) GO TO 6
C** RECORD THE ATOMS IN INOV THAT NEIGHBOR ATOM IR
         DO M=1,NM
            IN=NATM(M,MKJI)
            IF(IN.NE.IR) THEN
               IO=IO+1
	       if(IO.gt.ICT) then
		  write(22,*) 'IO=', IO, 'ICT=', ICT
		  stop
	       endif
               DX(IO)=XR-X(IN)
               DY(IO)=YR-Y(IN)
               DSQ(IO)=DX(IO)**2+DY(IO)**2
               D(IO)=SQRT(DSQ(IO))
               INOV(IO)=IN
            ENDIF
         ENDDO
    6 CONTINUE   
	
   14 IF(IO.NE.0)GO TO 17
      AREA=PIX2*RRX2
      GO TO 18

   17 continue

C** Z RESOLUTION DETERMINED
      NZP=1./P+0.5
      ZRES=RRX2/NZP
      ZGRID=Z(IR)-RR-ZRES/2.

C** SECTION ATOM SPHERES PERPENDICULAR TO THE Z AXIS
      DO 9 I=1,NZP
         ZGRID=ZGRID+ZRES
C** FIND THE RADIUS OF THE CIRCLE OF INTERSECTION OF THE IR SPHERE
C** ON THE CURRENT Z-PLANE
         RSEC2R=RRSQ-(ZGRID-ZR)**2
         RSECR=SQRT(RSEC2R)
         DO K=1,KARC
            ARCI(K)=0.0
         ENDDO
         KARC=0
         DO 10 J=1,IO
            IN=INOV(J)
C** FIND RADIUS OF CIRCLE LOCUS
            RSEC2N=RADSQ(IN)-(ZGRID-Z(IN))**2
            IF(RSEC2N.LE.0.0)GO TO 10
            RSECN=SQRT(RSEC2N)
C** FIND INTERSECTIONS OF N.CIRCLES WITH IR CIRCLES IN SECTION
            IF(D(J).GE.RSECR+RSECN)GO TO 10
C** DO THE CIRCLES INTERSECT, OR IS ONE CIRCLE COMPLETELY INSIDE THE OTHER?
            B=RSECR-RSECN
            IF(D(J).GT.ABS(B))GO TO 20
            IF(B.LE.0.0) GO TO 9
            GO TO 10
C** IF THE CIRCLES INTERSECT, FIND THE POINTS OF INTERSECTION
   20       KARC=KARC+1
            ALPHA=ACOS((DSQ(J)+RSEC2R-RSEC2N)/(2.*D(J)*RSECR))
            BETA=ATAN2(DY(J),DX(J))+PI
            TI=BETA-ALPHA
            TF=BETA+ALPHA
            IF(TI.LT.0.0)TI=TI+PIX2
            IF(TF.GT.PIX2)TF=TF-PIX2
            ARCI(KARC)=TI
            IF(TF.LT.TI) THEN
               ARCF(KARC)=PIX2
               KARC=KARC+1
	    ENDIF
            ARCF(KARC)=TF
   10    CONTINUE

C** FIND THE ACCESSIBLE CONTACT SURFACE AREA FOR THE SPHERE IR ON
C** THIS SECTION
         IF(KARC.EQ.0) THEN
            ARCSUM=PIX2
         ELSE
            CALL SORTAG(ARCI(1),KARC,TAG)
C** CALCULATE THE ACCESSIBLE AREA
            ARCSUM=ARCI(1)
            T=ARCF(TAG(1))
            IF(KARC.NE.1) THEN
            DO K=2,KARC
               IF(T.LT.ARCI(K))ARCSUM=ARCSUM+ARCI(K)-T
               TT=ARCF(TAG(K))
               IF(TT.GT.T)T=TT
            ENDDO
	    ENDIF
            ARCSUM=ARCSUM+PIX2-T
         ENDIF

         PAREA=ARCSUM*ZRES
         AREA=AREA+PAREA
    9 CONTINUE

   18 B=AREA*(RR-RH2O)**2/RR
      ATAREA(IR)=B
    5 CONTINUE

      RETURN
      END


c ************************************************************************

      SUBROUTINE SORTAG(A,N,TAG)
      INTEGER TAG,TG
      DIMENSION A(N),IU(16),IL(16),TAG(N)
      DO I=1,N
      TAG(I)=I
      ENDDO
      M=1
      I=1
      J=N
  5   IF(I.GE.J) GO TO 70
 10   K=I
      IJ=(J+I)/2
      T=A(IJ)
      IF(A(I).LE.T) GO TO 20
      A(IJ)= A(I)
      A(I)=T
      T=A(IJ)
      TG=TAG(IJ)
      TAG(IJ)=TAG(I)
      TAG(I)=TG
 20   L=J
      IF(A(J).GE.T) GO TO 40
      A(IJ)=A(J)
      A(J)=T
      T=A(IJ)
      TG=TAG(IJ)
      TAG(IJ)=TAG(J)
      TAG(J)=TG
      IF(A(I).LE.T) GO TO 40
      A(IJ)=A(I)
      A(I)=T
      T=A(IJ)
      TG=TAG(IJ)
      TAG(IJ)=TAG(I)
      TAG(I)=TG
      GO TO 40
 30   A(L)=A(K)
      A(K)=TT
      TG=TAG(L)
      TAG(L)=TAG(K)
      TAG(K)=TG
 40   L=L-1
      IF(A(L).GT.T) GO TO 40
      TT=A(L)
 50   K=K+1
      IF(A(K).LT.T) GO TO 50
      IF(K.LE.L) GO TO 30
      IF(L-I.LE.J-K) GO TO 60
      IL(M)=I
      IU(M)=L
      I=K
      M=M+1
      GO TO 80
 60   IL(M)=K
      IU(M)=J
      J=L
      M=M+1
      GO TO 80
 70   M=M-1
      IF(M.EQ.0) RETURN
      I=IL(M)
      J=IU(M)
 80   IF(J-I.GE.1) GO TO 10
      IF(I.EQ.1) GO TO 5
      I=I-1
 90   I=I+1
      IF(I.EQ.J) GO TO 70
      T=A(I+1)
      IF(A(I).LE.T) GO TO 90
      TG=TAG(I+1)
      K=I
 100  A(K+1)=A(K)
      TAG(K+1)=TAG(K)
      K=K-1
      IF(T.LT.A(K)) GO TO 100
      A(K+1)=T
      TAG(K+1)=TG
      GO TO 90
      END

