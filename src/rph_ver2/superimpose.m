%% superimpose two plots

fh1 = open('/Users/seongwoohan/Desktop/rph_v3/3:7/os2.fig');
fh2 = open('/Users/seongwoohan/Desktop/rph_v3/3:7/od2.fig');
ax1 = get(fh1, 'Children');
ax2 = get(fh2, 'Children');
ax2p = get(ax2(1),'Children');
copyobj(ax2p, ax1(1));