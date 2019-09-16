#!/usr/bin/perl
# This is a quick hack to check if JPGs are in archive
#   (using similarity to accept cropping, sharpening, color fix...)
#
# - collects all files from SRC
# - filter SRC list to get only JPG
# - checks if a file with same filehash exists (if so, it obviously exists)
# - otherwise, symlink to MISSING folder (that contains images
#   that do not binrary wise exist in arc)
# - otherwise, all files with same name (and different filehash) are compared
#   with imagemagick compare metric
# - if metric > 25 (empirically picked value) count as "very similar existing"
#   so produce a state file 0000_A_FOUND
# - if none of the same named files is "very similar", produce a
#   state file 0000_A_MISSING
#
# TODO:
# - fails if two picks have same file name,
#   then we have two 0000_Google_xxx_jpg and maybe
#   A_MISSING plus one or more A_FOUND :(
# - avoid comaparing with itself and remove special handling for PSNR==0 (equality)
# - how to evalutate the result / state files?
# - What next? delete existing from MISSING?
# -- maybe first check if all Google Takeout files have at least
#    one instance in a date folder?
# - how to handle result?
#   state file extension bin (bad) because alert-alike icon (VLC),
#   extension .sfv (good) is a green check icon in win 7 explorer
#
# Notes:
#   ARC "/raid1/pics/arc"
#       (the pic archive)
#   SRC "/raid1/pics/GooglePhotos/Takeout/Google Fotos"
#       (from ZIP "D:\01_GooglePhotoDownload")
#   TMP $missingroot="/raid1/pics/GooglePhotos/Takeout/missing/"
#
# Some metrics:
#   Found    54292 Google entries in /raid1/pics/GooglePhotos/Takeout/Google Fotos
#   Found    24105 Google JPGs in /raid1/pics/GooglePhotos/Takeout/Google Fotos
#   Found   102904 ARC entries in /raid1/pics/arc
#   Found    87383 ARC JPGs in /raid1/pics/arc
use strict;
#use utf8;
use File::Basename;
#use Digest::MD5 qw(md5_hex);

binmode( STDOUT, 'utf8:' );


my $filelist = "/raid1/pics/GooglePhotos/Takeout/files.txt";
my $googleroot = "/raid1/pics/GooglePhotos/Takeout/Google Fotos";
my $arcroot = "/raid1/pics/arc";

# Recursively finds JPGs
sub findJpg($)
{
    my $path = shift;
    my $handle;
    # We use "find */" to "follow first-level symlinks"
    open $handle, "-|:encoding(UTF-8)", "cd '$path' && find */ -type f"
      or die "Could pipe find in '$path;': $!\n";
    chomp(my @arcimages = <$handle>);
    close $handle
      or die "Don't care error while closing pipe find in '$path': $!\n";
    return @arcimages;
}

# Filter off all known non-Jpgs (i.e. keep Jpg and unknown)
sub filterJpg($)
{
    my $inlist = shift;
    my @jpgs = @${inlist};

    @jpgs = grep { !/.(json|mp4|mts|m4v|mov|avi|bin)$/i } @jpgs;
    @jpgs = grep { !/.(par2|db|db.1|db.2|info|info.1|cr2|tmp|thm|ini|cpt|7z|log|zip|tps|xmp|putt|pspimage|rss|hdr)$/i } @jpgs;
    @jpgs = grep { !/.(gif|png|pdf|psd|webp)$/i } @jpgs;
    @jpgs = grep { !/descript.ion(.1)?|Online.url anzeigen$/i } @jpgs;
    # Some strange webp files without extension, like "./2019-04-04/13.07(1).14 - 1"
    @jpgs = grep { !/\/\d\d[.]\d\d([(]\d+[)])?[.]\d\d - [123]$/i } @jpgs;
    # Test: remove jpgs
    #@jpgs = grep { !/.(jpg|jpeg)$/i } @jpgs;
}


my @images = findJpg($googleroot);
printf "Found %8d Google entries in $googleroot\n", $#images + 1;
@images = filterJpg(\@images);
# renumbered inside, checked manually (OK)
@images = grep { !/^2015_12_09\//i } @images;
printf "Found %8d Google JPGs in $googleroot\n", $#images + 1;

#open T, ">/tmp/f3.lst";
#print T join("\n", @images);
#close T;

my @arcimages = findJpg($arcroot);
printf "Found %8d ARC entries in $arcroot\n", $#arcimages + 1;
@arcimages = filterJpg(\@arcimages);
printf "Found %8d ARC JPGs in $arcroot\n", $#arcimages + 1;

my $arcimages = {};
# this processing takes > 500ms!
foreach my $arcimage (@arcimages) {
  my $lcfile=lc(basename($arcimage));
  my $show = 0;
  if (!exists $arcimages->{$lcfile}) {
    $arcimages->{$lcfile} = [];
  } else {
    # $show = 1;
  }
  #if ($lcfile eq lc("IMG_1077.jpg")) { $show = 1; }
  # We expect that we have to check each file twice, so lets allowing store
  # hash too, but calc on demand only (i.e. cache file hashes)
  push @{$arcimages->{$lcfile}}, { path => $arcimage };
  if ($show) {
    use Data::Dumper;
    print Data::Dumper->Dump( [$arcimages->{$lcfile}], ["add_arcimages_$lcfile"] );
  }
}

#{
#    use Data::Dumper;
#    print Data::Dumper->Dump( [$arcimages->{"img_1077.jpg"}], ["img_1077"] );
#}

for (my $n=1; $n<100; $n++) {
  my $pickidx = int(rand($#images + 1));
  my $pickedfull = $images[$pickidx];
  # $pickedfull = "Silvester 2012/IMG_0113.JPG";
  #$pickedfull = "2018-08-18/DSC_0003.JPG";
  #$pickedfull = "2015_12_09/IMG_1077.jpg";
  # printf "Picked %8d = %s\n", $pickidx, $googleroot . "/" . $pickedfull;
  my $gpath = $googleroot . "/" . $pickedfull;
  my ($ghash, $rest) = split /\s+/, `md5sum '$gpath'`;
  my $picked=basename($pickedfull);
  my $lcfile = lc($picked);
  # printf "Picked #%8d: %s (%s)\n", $pickidx, $pickedfull, $ghash;
  my $found = 0;
  if (exists $arcimages->{$lcfile}) {
    #use Data::Dumper;
    #print Dumper $arcimages->{$lcfile};

    my $arcmatches =  $arcimages->{$lcfile};
    foreach my $arcmatch (@$arcmatches) {
       my $path = $arcroot . "/" . $arcmatch->{path};
       if (!exists ($arcmatch->{md5sum})) {
         # 62620688f7c28517e5e5e88788ab9abb  /raid1/pics/arc/2016/2016_07_29/DSC_0003.JPG
         my ($sum, $rest) = split /\s+/, `md5sum '$path'`;
         $arcmatch->{md5sum} = $sum;
       }
       if ($arcmatch->{md5sum} eq $ghash) {
         $found = $arcmatch;
       }
    }

    #use Data::Dumper;
    #print Dumper $arcimages->{$lcfile};
  }

  # TODO FIXME HACK we dont have 2019 on server yet, so skip these
  #if ($pickedfull =~ m/2019-/) {
  #  printf "  x %8s: #%7d %s\n", "Skipping", $pickidx, $pickedfull;
  #  next;
  #}

  {
    my $missingroot="/raid1/pics/GooglePhotos/Takeout/missing/";
    `[ -d '$missingroot' ] || mkdir '$missingroot'`;
  }
  if ($found) {
    #use Data::Dumper;
    #print Dumper $found, "found";
    printf "+++ %8s: #%7d %s\n", "Found", $pickidx, $pickedfull;
    `ln -fs '../Google Fotos/$pickedfull' '/raid1/pics/GooglePhotos/Takeout/found/'`;
  } else {
    if (exists $arcimages->{$lcfile}) {
      my $samenamecount = $#{$arcimages->{$lcfile}} + 1;
      my $samestr = sprintf "Name %3d", $samenamecount;
      printf "  = %8s: #%7d %s\n", , $samestr, $pickidx, $pickedfull;
      if (0) {
        printf "xxx %d -> %d -> %s\n", $#{$arcimages->{$lcfile}}, $samenamecount;
        use Data::Dumper;
        print Data::Dumper->Dump( [$arcimages->{$lcfile} ], ["lcfile"] );
        die "end"
      }
      # FIXME if two picks have same name, we re-use an existing directory here!
      my $dir = $picked;
      $dir =~ s/.jpe?g$//i;
      my $destdir="/raid1/pics/GooglePhotos/Takeout/missing/$dir";
      `[ -d '$destdir' ] || mkdir '$destdir'`;
      my $gdest = $pickedfull;
      $gdest =~ tr|a-zA-Z0-9_.-|!|c;
      `ln -fs '../../Google Fotos/$pickedfull' '$destdir/0000_GooglePhotos__$gdest'`;
      foreach my $arcmatch (@{$arcimages->{$lcfile}}) {
        my $path = $arcroot . "/" . $arcmatch->{path};
        my $dest = $arcmatch->{path};
        $dest =~ tr|a-zA-Z0-9_.-|!|c;
        #print "$picked  --> $dest\n";
        `ln -fs '$path' '$destdir/$dest'`;
      }
      {
        # FIXME fails if two picks have same file name,
        # then we have two 0000_Google_xxx_jpg and maybe
        # A_MISSING plus one or more A_FOUND :(
        if (1) {
          # [ -d t ] || mkdir t
          # rm -f DIFF_*.JPG;
          # mogrify -path t -thumbnail 128x128 *.JPG
          # for i in *JPG ; do
          #   # compare -metric PSNR 0000_*.JPG "$i" "DIFF_$i";
          #   echo "$i:" ;
          #   r=$(compare -metric PSNR 0000_*.JPG "$i" "DIFF_$i" 2>&1);
          #   ret=$?;
          #   echo "RESULT: $ret ($r)";
          #   echo; echo;
          # done
          # 2:
          # rm -f DIFF_*.JPG; for i in *JPG ; do echo "$i:" ; r=$(compare -metric PSNR 0000_*.JPG "$i" "DIFF_$i" 2>&1); ret=$?; rf=$( LC_ALL=C printf "%07.2f" $r 2>/dev/null) ; echo "RESULT: $ret --> $rf ($r))"; mv  "DIFF_$i"  "DIFF_${rf}_${i}" ; echo; echo; done
          # 3:
          # rm -f *_DIFF_*.JPG; for i in *JPG ; do echo "$i:" ; r=$(compare -metric PSNR "$i" 0000_*.JPG "tmp_DIFF_$i" 2>&1); ret=$?; rf=$( LC_ALL=C printf "%07.2f" $r 2>/dev/null) ; echo "RESULT: $ret --> $rf ($r))"; mv  "tmp_DIFF_$i"  "JPG_DIFF_${rf}_${i}" ; echo; echo; done

          # NOTE: state file extension bin (bad) because
          # alert-alike icon (VLC), extension .sfv (good) is a green check icon
          # in win 7 explorer
          print `
            cd '$destdir';
            [ -d tmp ] || mkdir tmp;
            mogrify -path tmp -thumbnail 128x128 *.JPG;
            cd tmp;
            pwd;
            rm -f *_DIFF_*.JPG 0000_A_FOUND* 0000_A_MISSING*;
            touch 0000_A_MISSING.bin;
            for i in *[Jj][Pp][Gg]; do
              echo "Analysing \$i:";
              r=\$(compare -metric PSNR "\$i" 0000_*.JPG "tmp_DIFF_\$i" 2>&1);
              ret=\$?;
              echo "ret=\$ret, r=\$r";
              if [ \$ret -eq 0 ] ; then
                echo "FOUND SAME";
                mv "tmp_DIFF_\$i" "JPG_DIFF_\${rf}_\${i}";
              elif [ \$ret -eq 1 ] ; then
                rf=\$( LC_ALL=C printf "%06.2f" \$r 2>/dev/null);
                ri=\${r%%.*};
                echo "RESULT: \$ret --> \$rf (\$r) --> \$ri";
                mv "tmp_DIFF_\$i" "JPG_DIFF_\${rf}_\${i}";
                if [ "\$ri" -gt 25 ] ; then
                  echo "FOUND (with \$r)!";
                  rm -f 0000_A_MISSING.bin;
                  touch 0000_A_FOUND_\${rf}_\${i}.sfv;
                else
                  echo "NOT_FOUND (with \$r)";
                fi
              else
                echo "UNCOMPARABLE (\$ret:\$r)";
              fi
              echo; echo;
            done;
            cp -a 0000_A_* ..;
          `;
        }
      }
    } else {
      printf "--- %8s: #%7d %s\n", "Missing", $pickidx, $pickedfull;
      `ln -fs '../Google Fotos/$pickedfull' '/raid1/pics/GooglePhotos/Takeout/missing/'`;
    }
  }
  # die "debug end\n";
}

#for (my $n=1; $n<10; $n++) {
#  my $pickidx = int(rand($#arcimages + 1));
#  my $pickedfull = $arcimages[$pickidx];
#  printf "Picked ARC #%8d: %s\n", $pickidx, $arcroot . "/" . $pickedfull;
#  my $picked=basename($pickedfull);
#  printf "Picked ARC #%8d: %s\n", $pickidx, $picked;
#}
#



####
#
# wrong file name
# 0000_GooglePhotos__2015_12_09!IMG_1077.jpg
#     --> D:\av\pics\arc\2015\2015_12_10\IMG_0047.JPG
# new numbering for D:\av\pics\arc\GooglePhotos\Takeout\Google Fotos\2015_12_09
#
# MISSING RUN 1
#   0000_GooglePhotos__2019-07-18!DSC_0160.JPG
#     -> hole in date range!
#
#   0000_GooglePhotos__2019-07-20!DSC_0276.JPG
#     -> hole in date range!
#
#   0000_GooglePhotos__Reise!nach!Ungarn!und!Tschechien!DSC_2131.JPG
#     -> diffrent of same day 2017!2017_09_22!DSC_2131.JPG
#     -> similar of same day IMG_9949.JPG
#
#   0000_GooglePhotos__2015_10_31_Abitreffen_Jan_Wehrmann!DSC04093.JPG
#     -> maybe foreign
#
#   OK 0000_GooglePhotos__2017-03-25!DSCF2652.JPG
#   OK   -> fremde kamera
#   OK   -> from_others/2017_03_25_Hochzeitsfeier/Hochzeit_von_Gordon_K/DSCF2652.JPG
#
#   OK 0000_GooglePhotos__2017_03_09_ski!IMG_0002_1.JPG
#   OK   -> D:\av\pics\arc\2017\2017_03_11\DSC01640.JPG
#
#   OK 0000_GooglePhotos__2019-03-16!IMG_0018.JPG
#   OK   -> D:\pics\2019_03_17\DSC01712.JPG
